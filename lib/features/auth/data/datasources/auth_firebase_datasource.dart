import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/app_exception.dart';
import '../../../../core/error/global_error_handler.dart';
import '../../../../common/imports/imports.dart' show AppStrings;

@lazySingleton
class AuthFirebaseDataSource {
  AuthFirebaseDataSource(this._firebaseAuth, this._firebaseMessaging);

  final FirebaseAuth _firebaseAuth;
  final FirebaseMessaging _firebaseMessaging;

  /// Triggers SMS via Firebase Phone Auth and returns a [verificationId]
  /// that the verify step must echo back along with the SMS code.
  Future<String> requestSmsCode(String phone, {int? resendToken}) {
    return rethrowAsAppException(() async {
      final completer = Completer<String>();
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        forceResendingToken: resendToken,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential _) {
          // Android instant verification: not used in v1; user types the code.
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!completer.isCompleted) {
            completer.completeError(_mapFirebaseError(e));
          }
        },
        codeSent: (String verificationId, int? _) {
          if (!completer.isCompleted) completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (_) {
          /* no-op */
        },
      );
      return completer.future;
    });
  }

  /// Signs the user into Firebase with the SMS code, then returns a fresh
  /// Firebase ID token to send to the backend for verification.
  Future<String> signInAndGetIdToken({
    required String verificationId,
    required String smsCode,
  }) {
    return rethrowAsAppException(() async {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      final idToken = await userCredential.user?.getIdToken(true);
      if (idToken == null || idToken.isEmpty) {
        throw const AppException('Could not retrieve Firebase ID token');
      }
      return idToken;
    });
  }

  /// Best-effort FCM device token. Returns null on any failure (the login
  /// endpoint accepts a missing token).
  Future<String?> getFcmToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (_) {
      return null;
    }
  }

  AppException _mapFirebaseError(FirebaseAuthException e) {
    final msg = switch (e.code) {
      'invalid-phone-number' => AppStrings.invalidPhoneNumber,
      'too-many-requests' => AppStrings.tooManyRequests,
      'quota-exceeded' => AppStrings.somethingWentWrong,
      _ => e.message ?? AppStrings.somethingWentWrong,
    };
    return AppException(msg);
  }
}
