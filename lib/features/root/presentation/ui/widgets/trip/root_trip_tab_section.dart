import 'package:flutter/material.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trips_body.dart';

class RootTripTabSection extends StatelessWidget {
  const RootTripTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    // No BlocProvider here on purpose: DashboardTripsBody owns its own
    // DashboardBloc. Wrapping it in a second one spawned an unread bloc that
    // still subscribed to realtime, so every trip event refetched the list
    // twice.
    return const SafeArea(
      bottom: false,
      child: DashboardTripsBody(showBackButton: false),
    );
  }
}
