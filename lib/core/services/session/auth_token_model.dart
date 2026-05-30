import 'package:dio_refresh_bot/dio_refresh_bot.dart';

/// Concrete token model used by the app.
///
/// Extends [AuthToken] from dio_refresh_bot so it can be consumed directly
/// by the refresh interceptor while remaining easy to construct from API
/// responses and storage.
class AuthTokenModel extends AuthToken {
  const AuthTokenModel({
    required super.accessToken,
    super.tokenType,
    super.refreshToken,
    super.expiresIn,
  });

  /// Creates an [AuthTokenModel] from a raw JSON map.
  factory AuthTokenModel.fromMap(Map<String, dynamic> map) {
    final accessToken = map['accessToken'] ?? map['AccessToken'];
    final refreshToken = map['refreshToken'] ?? map['RefreshToken'];
    final tokenType =
        map['tokenType'] ?? map['TokenType'] ?? AuthToken.defaultTokenType;
    final expiresIn = map['expiresIn'] ?? map['ExpiresIn'];

    return AuthTokenModel(
      accessToken: accessToken as String,
      tokenType: tokenType as String,
      refreshToken: refreshToken as String?,
      expiresIn: expiresIn is int ? expiresIn : null,
    );
  }
}
