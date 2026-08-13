import '../injection/injectable.dart';
import '../services/session/jwt_token_storage.dart';

/// Headers for media fetched straight from the API host by widgets that bypass
/// the Dio client (`CachedNetworkImage`, `Image.network`).
///
/// Driver KYC documents (`/documents/...`) are the one upload area the API
/// authorizes on download — `ProtectedFilesMiddleware` requires the caller to be
/// the owning driver — so those requests must carry the bearer token. Widgets
/// that render a document URL without these headers get a 401.
Map<String, String> mediaAuthHeaders() {
  final headers = <String, String>{
    // The free ngrok tunnel returns an HTML warning page instead of the file
    // unless this is present. No-op in production.
    'ngrok-skip-browser-warning': '69420',
  };

  final token = getIt<JwtTokenStorage>().read();
  final accessToken = token?.accessToken;
  if (accessToken != null && accessToken.isNotEmpty) {
    headers['Authorization'] = 'Bearer $accessToken';
  }

  return headers;
}
