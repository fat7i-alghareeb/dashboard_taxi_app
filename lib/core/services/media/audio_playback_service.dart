import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../network/media_url.dart';

/// A single shared audio player for the admin recordings UI, so only ONE
/// recording plays at a time across the whole app. Tiles drive it by `id` and
/// listen to its streams to reflect play/pause/position.
@lazySingleton
class AudioPlaybackService {
  AudioPlaybackService() {
    // When a clip finishes, clear the active id so its tile resets to "play".
    _player.onPlayerComplete.listen((_) => _currentId.value = null);
  }

  final AudioPlayer _player = AudioPlayer();
  final ValueNotifier<String?> _currentId = ValueNotifier<String?>(null);

  /// The id of the recording currently loaded (playing or paused), or null.
  ValueListenable<String?> get currentId => _currentId;

  Stream<Duration> get onPosition => _player.onPositionChanged;
  Stream<Duration> get onDuration => _player.onDurationChanged;
  Stream<PlayerState> get onState => _player.onPlayerStateChanged;

  bool get isPlaying => _player.state == PlayerState.playing;

  bool isCurrent(String id) => _currentId.value == id;

  /// Plays [url] for [id]. If [id] is already active, toggles pause/resume.
  Future<void> toggle(String id, String url) async {
    if (_currentId.value == id) {
      if (_player.state == PlayerState.playing) {
        await _player.pause();
      } else {
        await _player.resume();
      }
      return;
    }
    _currentId.value = id;
    await _player.stop();
    await _player.play(UrlSource(resolveMediaUrl(url)));
  }

  Future<void> seek(Duration position) => _player.seek(position);

  /// Stops playback and clears the active id. Call from screen dispose.
  Future<void> stop() async {
    await _player.stop();
    _currentId.value = null;
  }
}
