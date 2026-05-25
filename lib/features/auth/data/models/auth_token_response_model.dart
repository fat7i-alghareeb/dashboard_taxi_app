import '../../../../core/services/session/auth_token_model.dart';

class AuthTokenResponseModel {
  const AuthTokenResponseModel({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory AuthTokenResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenResponseModel(
      accessToken: (json['accessToken'] ?? json['AccessToken']) as String,
      refreshToken: (json['refreshToken'] ?? json['RefreshToken']) as String,
    );
  }

  AuthTokenModel toAuthTokenModel() {
    return AuthTokenModel(accessToken: accessToken, refreshToken: refreshToken);
  }
}
