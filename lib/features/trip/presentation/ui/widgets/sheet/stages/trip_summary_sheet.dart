import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_summary_panel_widget.dart';

/// Stage 5: trip just completed. Reuses the existing summary card so the
/// fare/CTA visuals stay consistent with prior screens.
class TripSummarySheet extends StatelessWidget {
  const TripSummarySheet({super.key, required this.trip});

  final TripEntity trip;

  @override
  Widget build(BuildContext context) {
    return TripSummaryPanelWidget(trip: trip);
  }
}
