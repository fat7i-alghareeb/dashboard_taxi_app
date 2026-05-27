import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_icon_action_widget.dart';

class DashboardLiveMapHeaderWidget extends StatelessWidget {
  const DashboardLiveMapHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.dashboardLiveMap,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s14w600.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  Row(
                    children: [
                      Container(
                        width: 6.r,
                        height: 6.r,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      AppSpacing.sm.horizontalSpace,
                      Flexible(
                        child: Text(
                          AppStrings.dashboardLiveMapSubtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s12w400.copyWith(
                            color: context.onSurface.withValues(alpha: 0.55),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            DashboardIconActionWidget(
              icon: FontAwesomeIcons.arrowsRotate,
              tooltip: AppStrings.dashboardRefresh,
              onTap: () => context.read<DashboardBloc>().add(
                const DashboardEvent.driverLocationsRequested(),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 280.ms).slideY(begin: -0.05, end: 0);
  }
}
