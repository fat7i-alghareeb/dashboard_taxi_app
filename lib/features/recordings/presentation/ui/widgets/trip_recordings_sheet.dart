import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/services/media/audio_playback_service.dart';

import '../../../data/datasources/recordings_remote_datasource.dart';
import '../../../domain/entities/trip_recording_entity.dart';
import 'recording_player_tile.dart';

/// Bottom sheet that loads and plays the in-trip safety recordings for a single
/// trip. Used by the Records trip cards and the incident detail screen.
class TripRecordingsSheet extends StatefulWidget {
  const TripRecordingsSheet._({required this.tripId});

  final String tripId;

  static Future<void> show(BuildContext context, String tripId) {
    return AppBottomSheet.show<void>(
      context,
      sheet: AppBottomSheet.basic(
        title: AppStrings.recordingsTitle,
        scrollable: false,
        child: TripRecordingsSheet._(tripId: tripId),
      ),
    );
  }

  @override
  State<TripRecordingsSheet> createState() => _TripRecordingsSheetState();
}

class _TripRecordingsSheetState extends State<TripRecordingsSheet> {
  final RecordingsRemoteDataSource _dataSource =
      getIt<RecordingsRemoteDataSource>();

  bool _loading = true;
  String? _error;
  List<TripRecordingEntity> _items = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    getIt<AudioPlaybackService>().stop();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final models = await _dataSource.getTripRecordings(widget.tripId);
      if (!mounted) return;
      setState(() {
        _items = models.map((m) => m.toEntity).toList();
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.45.sh,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return EmptyStateWidget(
        text: _error,
        onRetrying: _load,
        retryLabel: AppStrings.retry,
      );
    }
    if (_items.isEmpty) {
      return Center(child: EmptyStateWidget(text: AppStrings.recordingsNone));
    }
    return ListView.builder(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final r = _items[index];
        final parts = <String>[
          if (r.recordedAt != null) r.recordedAt!.toLocal().toSmartDateTime(),
          if (r.durationSeconds != null) '${r.durationSeconds}s',
        ];
        return RecordingPlayerTile(
          id: r.id,
          url: r.fileUrl,
          title: r.type,
          subtitle: parts.join('  •  '),
          durationSeconds: r.durationSeconds,
        );
      },
    );
  }
}
