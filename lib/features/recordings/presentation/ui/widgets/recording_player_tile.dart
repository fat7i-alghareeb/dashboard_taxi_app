import 'package:audioplayers/audioplayers.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';

import '../../../../../core/services/media/audio_playback_service.dart';

/// A self-contained recording row with an in-app play/pause control and, while
/// active, a seekable progress bar. Backed by the shared [AudioPlaybackService]
/// so starting one recording pauses any other.
class RecordingPlayerTile extends StatefulWidget {
  const RecordingPlayerTile({
    super.key,
    required this.id,
    required this.url,
    required this.title,
    required this.subtitle,
    this.durationSeconds,
  });

  final String id;
  final String url;
  final String title;
  final String subtitle;
  final int? durationSeconds;

  @override
  State<RecordingPlayerTile> createState() => _RecordingPlayerTileState();
}

class _RecordingPlayerTileState extends State<RecordingPlayerTile> {
  final AudioPlaybackService _service = getIt<AudioPlaybackService>();

  late Duration _duration = Duration(seconds: widget.durationSeconds ?? 0);
  Duration _position = Duration.zero;
  bool _isCurrent = false;
  bool _isPlaying = false;

  StreamSubscription<PlayerState>? _stateSub;
  StreamSubscription<Duration>? _posSub;
  StreamSubscription<Duration>? _durSub;

  @override
  void initState() {
    super.initState();
    _isCurrent = _service.isCurrent(widget.id);
    _service.currentId.addListener(_onCurrentChanged);
    _stateSub = _service.onState.listen((state) {
      if (!_isCurrent) return;
      setState(() => _isPlaying = state == PlayerState.playing);
    });
    _posSub = _service.onPosition.listen((pos) {
      if (!_isCurrent) return;
      setState(() => _position = pos);
    });
    _durSub = _service.onDuration.listen((dur) {
      if (!_isCurrent) return;
      setState(() => _duration = dur);
    });
  }

  @override
  void dispose() {
    _service.currentId.removeListener(_onCurrentChanged);
    _stateSub?.cancel();
    _posSub?.cancel();
    _durSub?.cancel();
    super.dispose();
  }

  void _onCurrentChanged() {
    final current = _service.isCurrent(widget.id);
    setState(() {
      _isCurrent = current;
      if (!current) {
        _isPlaying = false;
        _position = Duration.zero;
      } else {
        _isPlaying = _service.isPlaying;
      }
    });
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final maxMs = _duration.inMilliseconds;
    final posMs = _position.inMilliseconds.clamp(0, maxMs == 0 ? 1 : maxMs);
    return Container(
      margin: REdgeInsets.only(bottom: AppSpacing.sm),
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _PlayButton(
                isPlaying: _isCurrent && _isPlaying,
                onTap: () => _service.toggle(widget.id, widget.url),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s14w600.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                    Text(
                      widget.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s12w500.copyWith(
                        color: context.onSurface.withValues(alpha: 0.60),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_isCurrent) ...[
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2.h,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.r),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 12.r),
              ),
              child: Slider(
                value: posMs.toDouble(),
                max: (maxMs == 0 ? 1 : maxMs).toDouble(),
                activeColor: context.primary,
                onChanged: (v) =>
                    _service.seek(Duration(milliseconds: v.round())),
              ),
            ),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _fmt(_position),
                    style: AppTextStyles.s11w500.copyWith(
                      color: context.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                  Text(
                    _fmt(_duration),
                    style: AppTextStyles.s11w500.copyWith(
                      color: context.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({required this.isPlaying, required this.onTap});

  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40.r),
      child: Container(
        width: 40.r,
        height: 40.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.primary.withValues(alpha: 0.12),
        ),
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          color: context.primary,
          size: 22.r,
        ),
      ),
    );
  }
}
