import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../utils/helpers/colored_print.dart';

@lazySingleton
class RootModeService extends ChangeNotifier {
  bool _isDriverMode = false;

  bool get isDriverMode => _isDriverMode;

  void showAdminMode() => _setDriverMode(false);

  void showDriverMode() => _setDriverMode(true);

  void toggle() => _setDriverMode(!_isDriverMode);

  void _setDriverMode(bool value) {
    if (_isDriverMode == value) return;
    _isDriverMode = value;
    printM('[RootModeService] mode=${value ? 'driver' : 'admin'}');
    notifyListeners();
  }
}
