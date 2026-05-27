import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/facade/profile_facade.dart';

// ---------------------------------------------------------------------------
// Events
// ---------------------------------------------------------------------------

sealed class ProfileEvent {}

/// Load the profile for [isAdmin] ? admin : driver.
final class ProfileLoadRequested extends ProfileEvent {
  ProfileLoadRequested({required this.isAdmin});
  final bool isAdmin;
}

final class ProfileAdminUpdateRequested extends ProfileEvent {
  ProfileAdminUpdateRequested({
    required this.name,
    required this.email,
    this.phone1,
    this.phone2,
  });
  final String name;
  final String email;
  final String? phone1;
  final String? phone2;
}

final class ProfileDriverUpdateRequested extends ProfileEvent {
  ProfileDriverUpdateRequested({required this.name, this.email});
  final String name;
  final String? email;
}

final class ProfileUpdateAcknowledged extends ProfileEvent {}

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class ProfileState {
  const ProfileState({
    this.loadStatus = const BlocStatus.initial(),
    this.updateStatus = const BlocStatus.initial(),
    this.profile,
  });

  final BlocStatus<ProfileEntity> loadStatus;
  final BlocStatus<void> updateStatus;
  final ProfileEntity? profile;

  ProfileState copyWith({
    BlocStatus<ProfileEntity>? loadStatus,
    BlocStatus<void>? updateStatus,
    ProfileEntity? profile,
  }) {
    return ProfileState(
      loadStatus: loadStatus ?? this.loadStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      profile: profile ?? this.profile,
    );
  }
}

// ---------------------------------------------------------------------------
// BLoC
// ---------------------------------------------------------------------------

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._facade) : super(const ProfileState()) {
    on<ProfileLoadRequested>(_onLoadRequested);
    on<ProfileAdminUpdateRequested>(_onAdminUpdateRequested);
    on<ProfileDriverUpdateRequested>(_onDriverUpdateRequested);
    on<ProfileUpdateAcknowledged>(_onUpdateAcknowledged);
  }

  final ProfileFacade _facade;

  Future<void> _onLoadRequested(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    printM('[ProfileBloc] load requested isAdmin=${event.isAdmin}');
    emit(state.copyWith(loadStatus: const BlocStatus.loading()));

    final result = event.isAdmin
        ? await _facade.getAdminProfile()
        : await _facade.getDriverProfile();

    result.when(
      success: (profile) {
        printG('[ProfileBloc] load success id=${profile.id}');
        emit(
          state.copyWith(
            loadStatus: BlocStatus.success(profile),
            profile: profile,
          ),
        );
      },
      failure: (message) {
        printY('[ProfileBloc] load failed: $message');
        emit(state.copyWith(loadStatus: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onAdminUpdateRequested(
    ProfileAdminUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    printM('[ProfileBloc] admin update requested name=${event.name}');
    emit(state.copyWith(updateStatus: const BlocStatus.loading()));

    final result = await _facade.updateAdminProfile(
      name: event.name,
      email: event.email,
      phone1: event.phone1,
      phone2: event.phone2,
    );

    result.when(
      success: (profile) {
        printG('[ProfileBloc] admin update success');
        emit(
          state.copyWith(
            updateStatus: const BlocStatus.success(null),
            profile: profile,
          ),
        );
      },
      failure: (message) {
        printY('[ProfileBloc] admin update failed: $message');
        emit(state.copyWith(updateStatus: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onDriverUpdateRequested(
    ProfileDriverUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    printM('[ProfileBloc] driver update requested name=${event.name}');
    emit(state.copyWith(updateStatus: const BlocStatus.loading()));

    final result = await _facade.updateDriverProfile(
      name: event.name,
      email: event.email,
    );

    result.when(
      success: (profile) {
        printG('[ProfileBloc] driver update success');
        emit(
          state.copyWith(
            updateStatus: const BlocStatus.success(null),
            profile: profile,
          ),
        );
      },
      failure: (message) {
        printY('[ProfileBloc] driver update failed: $message');
        emit(state.copyWith(updateStatus: BlocStatus.failure(message)));
      },
    );
  }

  void _onUpdateAcknowledged(
    ProfileUpdateAcknowledged event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(updateStatus: const BlocStatus.initial()));
  }
}
