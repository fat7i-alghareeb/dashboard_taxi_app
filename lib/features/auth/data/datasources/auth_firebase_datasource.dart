import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/app_exception.dart';
import '../../../../core/error/global_error_handler.dart';
import '../../../../common/imports/imports.dart' show AppStrings;
import '../../../../utils/helpers/colored_print.dart';

@lazySingleton
class AuthFirebaseDataSource {
  AuthFirebaseDataSource(this._firebaseAuth, this._firebaseMessaging);

  final FirebaseAuth _firebaseAuth;
  final FirebaseMessaging _firebaseMessaging;

  /// Triggers SMS via Firebase Phone Auth and returns a [verificationId]
  /// that the verify step must echo back along with the SMS code.
  Future<String> requestSmsCode(String phone, {int? resendToken}) {
    return rethrowAsAppException(() async {
      printY(
        '[AuthFirebaseDataSource] requestSmsCode phone=$phone '
        'resend=${resendToken != null}',
      );
      final completer = Completer<String>();
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        forceResendingToken: resendToken,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential _) {
          printC('[AuthFirebaseDataSource] instant verification completed');
          // Android instant verification: not used in v1; user types the code.
        },
        verificationFailed: (FirebaseAuthException e) {
          printR(
            '[AuthFirebaseDataSource] verification failed code=${e.code} '
            'message=${e.message}',
          );
          if (!completer.isCompleted) {
            completer.completeError(_mapFirebaseError(e));
          }
        },
        codeSent: (String verificationId, int? _) {
          printG(
            '[AuthFirebaseDataSource] code sent verificationId=$verificationId',
          );
          if (!completer.isCompleted) completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (_) {
          printY('[AuthFirebaseDataSource] auto retrieval timeout');
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
      printY(
        '[AuthFirebaseDataSource] signInAndGetIdToken '
        'verificationId=$verificationId',
      );
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      final idToken = await userCredential.user?.getIdToken(true);
      if (idToken == null || idToken.isEmpty) {
        printR('[AuthFirebaseDataSource] id token missing after sign in');
        throw const AppException('Could not retrieve Firebase ID token');
      }
      printG(
        '[AuthFirebaseDataSource] signInAndGetIdToken success '
        'uid=${userCredential.user?.uid}',
      );
      return idToken;
    });
  }

  /// Best-effort FCM device token. Returns null on any failure (the login
  /// endpoint accepts a missing token).
  Future<String?> getFcmToken() async {
    try {
      printY('[AuthFirebaseDataSource] getFcmToken requested');
      final token = await _firebaseMessaging.getToken();
      printG(
        '[AuthFirebaseDataSource] getFcmToken '
        '${token == null ? 'empty' : 'success'}',
      );
      return token;
    } catch (error) {
      printY('[AuthFirebaseDataSource] getFcmToken failed: $error');
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
