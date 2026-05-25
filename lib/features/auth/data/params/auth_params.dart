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
