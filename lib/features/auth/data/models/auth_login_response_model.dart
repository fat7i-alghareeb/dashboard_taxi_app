import '../../../../core/domain/user_entity.dart';

class AuthLoginResponseModel {
  const AuthLoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  final String accessToken;
  final String refreshToken;
  final UserEntity user;

  factory AuthLoginResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthLoginResponseModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
