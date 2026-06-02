import '../../flavors.dart';
import '../../utils/helpers/colored_print.dart';

class ApiConfig {
  ApiConfig._();

  static bool _hasLoggedBaseUrl = false;

  static String get baseUrl {
    // const url = 'http://82.29.177.228:5001';
    const url = 'https://api.fat7i.dev';
    // const url = 'https://pecan-synergy-shush.ngrok-free.dev';
    _logBaseUrlOnce(url);
    return url;
  }

  static void _logBaseUrlOnce(String url) {
    if (_hasLoggedBaseUrl) return;
    _hasLoggedBaseUrl = true;

    if (url.isEmpty) {
      printY(
        '[ApiConfig] Base URL is empty for flavor: ${F.name}. Configure it before using network calls.',
      );
    } else {
      printC('[ApiConfig] Using base URL (${F.name}): $url');
    }
  }
}
