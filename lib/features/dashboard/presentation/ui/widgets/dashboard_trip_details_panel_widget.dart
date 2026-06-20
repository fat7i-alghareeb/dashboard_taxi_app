import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_details_body_widget.dart';

class DashboardTripDetailsPanelWidget extends StatelessWidget {
  const DashboardTripDetailsPanelWidget({super.key, required this.state});

  final BlocStatus<DashboardTripDetailsEntity> state;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardTripDetails,
      icon: FontAwesomeIcons.clipboardList,
      child: StatusBuilder<DashboardTripDetailsEntity>(
        state: state,
        init: () =>
            EmptyStateWidget(text: AppStrings.dashboardTripDetailsEmpty),
        loading: () => AppShimmer.box(
          width: double.infinity,
          height: 280,
          borderRadius: AppRadii.lg,
        ),
        success: (details) => DashboardTripDetailsBodyWidget(details: details),
      ),
    );
  }
}
