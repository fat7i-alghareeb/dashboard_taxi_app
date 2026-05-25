import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/constants/app_flow_constants.dart';
import '../../../utils/helpers/colored_print.dart';

enum StartupMapWarmupState { idle, warming, ready, timedOut }

@lazySingleton
class StartupMapWarmupCoordinator extends ChangeNotifier {
  Timer? _timeoutTimer;
  Timer? _progressTimer;

  StartupMapWarmupState _state = StartupMapWarmupState.idle;
  bool _hasStarted = false;
  bool _mapControllerAttached = false;
  double _progress = 0;

  StartupMapWarmupState get state => _state;
  double get progress => _progress;

  bool get isWarmupFinished =>
      _state == StartupMapWarmupState.ready ||
      _state == StartupMapWarmupState.timedOut;

  bool get didTimeout => _state == StartupMapWarmupState.timedOut;

  void ensureWarmupStarted() {
    if (_hasStarted) {
      return;
    }

    _hasStarted = true;
    _state = StartupMapWarmupState.warming;
    _progress = 0.05;

    printC(
      '[MapWarmup] started '
      'timeout=${SplashConfig.mapWarmupTimeout.inMilliseconds}ms',
    );

    _timeoutTimer = Timer(SplashConfig.mapWarmupTimeout, _completeWithTimeout);
    _progressTimer = Timer.periodic(
      const Duration(milliseconds: 120),
      _onProgressTick,
    );

    notifyListeners();
  }

  void onMapCreated() {
    _mapControllerAttached = true;
    printG('[MapWarmup] GoogleMap controller attached');
    _completeReady();
  }

  void _onProgressTick(Timer timer) {
    if (isWarmupFinished) {
      timer.cancel();
      return;
    }

    const maxWarmProgress = 0.92;
    final nextProgress = _progress + 0.02;
    _progress = nextProgress > maxWarmProgress ? maxWarmProgress : nextProgress;

    notifyListeners();
  }

  void _completeReady() {
    if (isWarmupFinished) {
      return;
    }

    _state = StartupMapWarmupState.ready;
    _progress = 1;
    _cancelTimers();

    printG('[MapWarmup] completed successfully');
    notifyListeners();
  }

  void _completeWithTimeout() {
    if (isWarmupFinished) {
      return;
    }

    _state = StartupMapWarmupState.timedOut;
    _progress = 1;
    _cancelTimers();

    printY(
      '[MapWarmup] timeout fallback triggered '
      'controllerAttached=$_mapControllerAttached',
    );
    notifyListeners();
  }

  void _cancelTimers() {
    _timeoutTimer?.cancel();
    _progressTimer?.cancel();
    _timeoutTimer = null;
    _progressTimer = null;
  }

  @override
  void dispose() {
    _cancelTimers();
    super.dispose();
  }
}
