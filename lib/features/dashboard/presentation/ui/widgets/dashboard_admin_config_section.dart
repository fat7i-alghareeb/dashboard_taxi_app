import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_admin_config_tile_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';

class DashboardAdminConfigSection extends StatelessWidget {
  const DashboardAdminConfigSection({
    super.key,
    required this.config,
    required this.isActionLoading,
  });

  final DashboardSystemConfigEntity config;
  final bool isActionLoading;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardSystemConfig,
      icon: FontAwesomeIcons.sliders,
      child: Wrap(
        spacing: AppSpacing.md.w,
        runSpacing: AppSpacing.md.h,
        children: [
          DashboardAdminConfigTileWidget(
            label: AppStrings.dashboardTripDiscount,
            value: '${config.tripDiscountPercent}%',
            actionLabel: AppStrings.dashboardSetFivePercent,
            isLoading: isActionLoading,
            onTap: () {
              context.read<DashboardBloc>().add(
                const DashboardEvent.tripDiscountUpdateRequested(5),
              );
            },
          ),
          DashboardAdminConfigTileWidget(
            label: AppStrings.dashboardCurrency,
            value: config.currencyCode,
            actionLabel: AppStrings.dashboardSetEuro,
            isLoading: isActionLoading,
            onTap: () {
              context.read<DashboardBloc>().add(
                const DashboardEvent.currencyUpdateRequested('EUR'),
              );
            },
          ),
          DashboardAdminConfigTileWidget(
            label: AppStrings.dashboardStripe,
            value: config.stripeEnabled
                ? AppStrings.dashboardEnabled
                : AppStrings.dashboardDisabled,
            actionLabel: AppStrings.dashboardReadOnly,
            isLoading: false,
            onTap: () {},
            isActive: false,
          ),
        ],
      ),
    );
  }
}
