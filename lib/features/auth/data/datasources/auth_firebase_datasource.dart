import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

import '../../../../utils/helpers/colored_print.dart';

/// Driver phone verification moved to the backend-owned OTP flow (CM.com SMS),
/// so all Firebase phone-auth logic is gone. Firebase Messaging is still used
/// only to obtain the FCM device token.
@lazySingleton
class AuthFirebaseDataSource {
  AuthFirebaseDataSource(this._firebaseMessaging);

  final FirebaseMessaging _firebaseMessaging;

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
}
