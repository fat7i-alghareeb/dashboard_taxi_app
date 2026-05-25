import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';

class DashboardAdminOperationsHeaderWidget extends StatelessWidget {
  const DashboardAdminOperationsHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppButton.outline(
          onTap: () => context.pop(),
          layout: const AppButtonLayout(shape: AppButtonShape.circle),
          child: AppButtonChild.icon(
            IconSource.icon(FontAwesomeIcons.arrowLeft),
            size: 18,
          ),
        ),
        AppSpacing.md.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.dashboardAdminOperations,
                style: AppTextStyles.s24w700.copyWith(color: context.onSurface),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                AppStrings.dashboardAdminOperationsSubtitle,
                style: AppTextStyles.s14w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.62),
                ),
              ),
            ],
          ),
        ),
        AppSpacing.md.horizontalSpace,
        AppButton.primary(
          onTap: () {
            context.read<DashboardBloc>().add(
              const DashboardEvent.adminOperationsRequested(),
            );
          },
          layout: const AppButtonLayout(shape: AppButtonShape.circle),
          child: AppButtonChild.icon(
            IconSource.icon(FontAwesomeIcons.arrowsRotate),
            size: 18,
          ),
        ),
      ],
    ).animate().fadeIn(duration: AppDurations.normal).slideY(begin: 0.05);
  }
}
