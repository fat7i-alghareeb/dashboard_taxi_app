import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:injectable/injectable.dart';
import 'package:dashboardtaxi/core/injection/injectable.dart';
import 'package:dashboardtaxi/core/network/api_endpoints.dart';
import 'package:dashboardtaxi/core/services/localization/locale_service.dart';
import 'package:dashboardtaxi/features/auth/domain/repositories/auth_repository.dart';

import '../../../utils/constants/auth_constants.dart';
import '../../../utils/helpers/colored_print.dart';
import '../../domain/extensions/user_role_extensions.dart';
import '../../domain/user_entity.dart';
import '../storage/storage_service.dart';
import 'auth_state_notifier.dart';
import 'auth_token_model.dart';
import 'jwt_token_storage.dart';

/// Central service responsible only for authentication concerns.
///
/// It exposes a simple API for login, logout, guest mode, user updates and
/// token updates, while keeping all persistence and reactive concerns hidden
/// behind dedicated collaborators.
@lazySingleton
class AuthManager {
  AuthManager({
    required this.storage,
    required this.state,
    required this.tokenStorage,
  });

  final StorageService storage;
  final AuthStateNotifier state;
  final JwtTokenStorage tokenStorage;

  StreamSubscription<AuthStatus>? _tokenStatusSub;

  UserEntity? get currentUser => state.user;
  bool get isGuest => state.isGuest;
  bool get isAuthenticated => state.isAuthenticated;
  AuthStatus get authStatus => state.authStatus;

  /// Emits authentication status changes coming from dio_refresh_bot.
  Stream<AuthStatus> get authStatusStream => tokenStorage.authenticationStatus;

  /// Initializes the manager by loading user and guest flag, and wiring token
  /// status updates when JWT mode is enabled.
  Future<void> initialize() async {
    printC('${AuthLogTags.authManager} initialize');
    await _loadUserFromStorage();
    printC(
      '${AuthLogTags.authManager} loaded storage user=${state.user?.id} '
      'role=${state.user?.role} guest=${state.isGuest} '
      'requiresPasswordReset=${state.user?.requiresPasswordReset}',
    );

    await tokenStorage.initialize();
    printC('${AuthLogTags.authManager} token storage initialized');
    _tokenStatusSub = tokenStorage.authenticationStatus.listen(
      _onAuthStatusChanged,
    );
    printC('${AuthLogTags.authManager} token status listener attached');

    final shouldLogExpiry = state.user != null && !state.isGuest;
    if (shouldLogExpiry) {
      final expiry = await tokenStorage.loadExpiry();
      final remaining = await tokenStorage.remainingUntilExpiry();

      if (expiry == null || remaining == null) {
        printY('${AuthLogTags.authManager} token expiry not available');
      } else if (remaining.isNegative) {
        printR('${AuthLogTags.authManager} token expired');
      } else {
        final days = remaining.inDays;
        final hours = remaining.inHours % 24;
        final minutes = remaining.inMinutes % 60;
        printG(
          '${AuthLogTags.authManager} token expires in: '
          '$days d, $hours h, $minutes m (at $expiry)',
        );
      }
    }

    final hasStoredUser = state.user != null && !state.isGuest;
    final hasValidTokens = await tokenStorage.hasValidTokens();
    printC(
      '${AuthLogTags.authManager} startup decision '
      'hasStoredUser=$hasStoredUser hasValidTokens=$hasValidTokens '
      'status=${state.authStatus.status}',
    );

    if (hasStoredUser && hasValidTokens) {
      printG('${AuthLogTags.authManager} restoring authenticated session');
      state.setAuthStatus(AuthStatus.authenticated());
      await _refreshCurrentUserProfileOnStartup();
      return;
    }

    // Make sure we don't stay in [Status.initial] while waiting for stream
    // emissions.
    if (state.authStatus.status == Status.initial) {
      printY('${AuthLogTags.authManager} no active session on startup');
      state.setAuthStatus(
        AuthStatus.unauthenticated(message: 'No active session'),
      );
    }
  }

  /// Disposes internal listeners and closes the underlying token storage.
  Future<void> dispose() async {
    await _tokenStatusSub?.cancel();
    tokenStorage.close();
  }

  /// Logs in the given [user], persists their data and optionally stores JWT
  /// tokens when JWT mode is active.
  Future<void> login({required UserEntity user, AuthTokenModel? token}) async {
    printG(
      '${AuthLogTags.authManager} login user=${user.id} role=${user.role} '
      'requiresPasswordReset=${user.requiresPasswordReset} '
      'hasToken=${token != null}',
    );

    await _persistUser(user);
    await _setGuest(false);

    // Update router-facing status immediately.
    state.setAuthStatus(AuthStatus.authenticated());

    if (token != null) {
      printC('${AuthLogTags.authManager} login writing token');
      await tokenStorage.write(token);
    }

    // Sync preferred language to backend post-login
    try {
      final localeService = getIt<LocaleService>();
      final langCode = await localeService.currentLanguageCode();
      final authRepo = getIt<AuthRepository>();
      unawaited(authRepo.updatePreferredLanguage(langCode));
      printG('${AuthLogTags.authManager} language synced post-login: $langCode');
    } catch (e) {
      printY('${AuthLogTags.authManager} language sync post-login failed: $e');
    }
  }

  /// Logs out the current user, clears persisted data and removes tokens.
  Future<void> logout() async {
    printY('${AuthLogTags.authManager} logout');

    await storage.remove(AuthStorageKeys.user);
    await storage.remove(AuthStorageKeys.guestFlag);

    state.setUser(null);
    state.setGuest(false);
    state.setAuthStatus(
      AuthStatus.unauthenticated(message: AuthReasons.logout),
    );

    await tokenStorage.delete(AuthReasons.logout);
  }

  /// Updates the persisted user data and notifies listeners.
  Future<void> updateUser(UserEntity user) async {
    printC(
      '${AuthLogTags.authManager} updateUser user=${user.id} role=${user.role} '
      'driverId=${user.driverId} approval=${user.approvalStatus} '
      'requiresPasswordReset=${user.requiresPasswordReset}',
    );
    await _persistUser(user);
  }

  /// Fetches the latest profile from the backend and synchronizes with storage.
  ///
  /// Picks the endpoint based on the current user's role: admins hit
  /// `/api/v1/admins/me`, every other role hits `/api/v1/users/me`. This keeps
  /// admin sessions usable after restart even though the backend exposes a
  /// separate admin profile endpoint.
  Future<void> refreshCurrentUserProfile() async {
    final endpoint = state.user.isAdmin
        ? ApiEndpoints.currentAdminProfile
        : ApiEndpoints.currentUser;
    printC(
      '${AuthLogTags.authManager} refreshCurrentUserProfile -> $endpoint',
    );
    final response = await getIt<Dio>().get(endpoint);
    printG(
      '${AuthLogTags.authManager} refreshCurrentUserProfile response '
      'status=${response.statusCode}',
    );
    final parsedUser = UserEntity.fromJson(
      response.data as Map<String, dynamic>,
    );
    printC(
      '${AuthLogTags.authManager} parsed profile user=${parsedUser.id} '
      'role=${parsedUser.role} driverId=${parsedUser.driverId} '
      'approval=${parsedUser.approvalStatus} '
      'requiresPasswordReset=${parsedUser.requiresPasswordReset}',
    );
    var user = parsedUser;
    if (parsedUser.requiresPasswordReset == null) {
      printY(
        '${AuthLogTags.authManager} profile omitted reset flag; '
        'preserved=${state.user?.requiresPasswordReset}',
      );
      user = user.copyWith(
        requiresPasswordReset: state.user?.requiresPasswordReset,
      );
    }
    // The /admins/me endpoint may not echo role/roles back; preserve what we
    // already know so role-aware UI keeps working.
    if (parsedUser.role == null && state.user?.role != null) {
      user = user.copyWith(role: state.user!.role);
    }
    if ((parsedUser.roles == null || parsedUser.roles!.isEmpty) &&
        state.user?.roles != null) {
      user = user.copyWith(roles: state.user!.roles);
    }
    await updateUser(user);
  }

  Future<void> _refreshCurrentUserProfileOnStartup() async {
    try {
      printC('${AuthLogTags.authManager} startup profile refresh start');
      await refreshCurrentUserProfile();
      printG('${AuthLogTags.authManager} startup profile refresh success');
    } catch (error) {
      printY(
        '${AuthLogTags.authManager} startup profile refresh failed: $error',
      );
    }
  }

  /// Updates the stored JWT token when JWT mode is active.
  Future<void> updateToken(AuthTokenModel token) async {
    printC('${AuthLogTags.authManager} updateToken');
    await tokenStorage.write(token);
  }

  /// Enters guest mode by clearing the user and setting the guest flag.
  Future<void> continueAsGuest() async {
    printC('${AuthLogTags.authManager} continueAsGuest');

    state.setUser(null);
    await _setGuest(true);
    state.setAuthStatus(AuthStatus.unauthenticated(message: AuthReasons.guest));

    await tokenStorage.delete(AuthReasons.guest);
  }

  /// Persists the given [user] in storage and updates the in-memory state.
  Future<void> _persistUser(UserEntity user) async {
    printC(
      '${AuthLogTags.authManager} persist user=${user.id} '
      'requiresPasswordReset=${user.requiresPasswordReset}',
    );
    state.setUser(user);

    final jsonString = json.encode(user.toJson());
    await storage.writeString(AuthStorageKeys.user, jsonString);
    printG('${AuthLogTags.authManager} user persisted to storage');
  }

  /// Persists the guest flag and updates the in-memory representation.
  Future<void> _setGuest(bool value) async {
    printC('${AuthLogTags.authManager} setGuest=$value');
    state.setGuest(value);
    await storage.writeBool(AuthStorageKeys.guestFlag, value);
  }

  /// Loads user and guest flag from storage to compute the initial state.
  Future<void> _loadUserFromStorage() async {
    final jsonString = await storage.readString(AuthStorageKeys.user);
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final decoded = json.decode(jsonString) as Map<String, dynamic>;
        final user = UserEntity.fromJson(decoded);
        printG(
          '${AuthLogTags.authManager} restored user from storage '
          'user=${user.id} requiresPasswordReset=${user.requiresPasswordReset}',
        );
        state.setUser(user);
      } catch (error) {
        printR('${AuthLogTags.authManager} load user failed: $error');
      }
    } else {
      printY('${AuthLogTags.authManager} no persisted user found');
    }

    final guestFlag = await storage.readBool(AuthStorageKeys.guestFlag);
    printC(
      '${AuthLogTags.authManager} restored guest flag=${guestFlag ?? false}',
    );
    state.setGuest(guestFlag ?? false);
  }

  /// Forwards status changes from dio_refresh_bot into the reactive notifier.
  void _onAuthStatusChanged(AuthStatus status) {
    printM(
      '${AuthLogTags.authManager} token auth status -> ${status.status} '
      'message=${status.message}',
    );
    state.setAuthStatus(status);
  }
}
