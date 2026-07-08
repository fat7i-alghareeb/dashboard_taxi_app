/// Legacy Firebase phone-session params (kept for backward compatibility).
class LoginParams {
  const LoginParams({
    required this.phone,
    required this.firebaseIdToken,
    this.fcmToken,
  });

  final String phone;
  final String firebaseIdToken;
  final String? fcmToken;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'phone': phone,
    'firebaseIdToken': firebaseIdToken,
    if (fcmToken != null) 'fcmToken': fcmToken,
  };
}

/// Request an SMS OTP for driver phone login (backend-owned OTP).
class PhoneOtpParams {
  const PhoneOtpParams({required this.phone, this.deviceId});

  final String phone;
  final String? deviceId;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'phone': phone,
    if (deviceId != null) 'deviceId': deviceId,
  };
}

/// Verify an issued phone-login OTP.
class VerifyOtpParams {
  const VerifyOtpParams({
    required this.otpRequestId,
    required this.code,
    this.fcmToken,
  });

  final String otpRequestId;
  final String code;
  final String? fcmToken;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'otpRequestId': otpRequestId,
    'code': code,
    if (fcmToken != null) 'fcmToken': fcmToken,
  };
}
