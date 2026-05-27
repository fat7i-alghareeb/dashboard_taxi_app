import '../../../../core/services/session/auth_token_model.dart';

class AdminLoginResponseModel {
  const AdminLoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.requiresPasswordReset,
  });

  final String accessToken;
  final String refreshToken;
  final bool requiresPasswordReset;

  factory AdminLoginResponseModel.fromJson(Map<String, dynamic> json) {
    return AdminLoginResponseModel(
      accessToken: (json['accessToken'] ?? json['AccessToken']) as String,
      refreshToken: (json['refreshToken'] ?? json['RefreshToken']) as String,
      requiresPasswordReset:
          (json['requiresPasswordReset'] ?? json['RequiresPasswordReset']) as bool? ?? false,
    );
  }

  AuthTokenModel toAuthTokenModel() {
    return AuthTokenModel(accessToken: accessToken, refreshToken: refreshToken);
  }
}
