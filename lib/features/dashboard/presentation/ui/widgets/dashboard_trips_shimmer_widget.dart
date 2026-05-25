import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';

class DashboardTripsShimmerWidget extends StatelessWidget {
  const DashboardTripsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardAllTrips,
      icon: FontAwesomeIcons.route,
      child: Column(
        children: List.generate(
          6,
          (index) => Padding(
            padding: REdgeInsets.only(bottom: AppSpacing.sm),
            child: AppShimmer.box(width: double.infinity, height: 72),
          ),
        ),
      ),
    );
  }
}
