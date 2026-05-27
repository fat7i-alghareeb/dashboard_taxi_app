import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_icon_action_widget.dart';

class DashboardTripsHeaderWidget extends StatelessWidget {
  const DashboardTripsHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardIconActionWidget(
          icon: context.chevronStart,
          tooltip: AppStrings.back,
          onTap: () => context.pop(),
        ),
        AppSpacing.md.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.dashboardTripsManagement,
                style: AppTextStyles.s24w700.copyWith(
                  color: context.onSurface,
                  height: 1.15,
                ),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                AppStrings.dashboardTripsManagementSubtitle,
                style: AppTextStyles.s12w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.55),
                ),
              ),
            ],
          ),
        ),
        AppSpacing.md.horizontalSpace,
        DashboardIconActionWidget(
          icon: FontAwesomeIcons.arrowsRotate,
          tooltip: AppStrings.dashboardRefresh,
          onTap: () {
            context.read<DashboardBloc>().add(
              const DashboardEvent.adminTripsRequested(),
            );
          },
        ),
      ],
    ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.04, end: 0);
  }
}
