import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// Lets non-root widgets request a root tab switch (e.g. tapping a trip in the
/// Trips tab to jump to the Home map). `RootBody` listens and drives its
/// `PageView`. Uses a consume-once pending index so repeated requests for the
/// same tab still fire.
@lazySingleton
class RootTabController extends ChangeNotifier {
  static const int homeTabIndex = 1;

  int? _pendingIndex;
  int? get pendingIndex => _pendingIndex;

  void goTo(int index) {
    _pendingIndex = index;
    notifyListeners();
  }

  void goToHome() => goTo(homeTabIndex);

  void consume() => _pendingIndex = null;
}
