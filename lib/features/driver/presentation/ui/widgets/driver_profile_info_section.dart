import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/domain/user_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_divider_widget.dart';
import 'package:dashboardtaxi/features/driver/presentation/ui/widgets/driver_profile_info_row_widget.dart';

class DriverProfileInfoSection extends StatelessWidget {
  const DriverProfileInfoSection({super.key, required this.user});

  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    final unknown = AppStrings.driverProfileUnknown;
    final role = user?.role?.trim().isNotEmpty == true
        ? user!.role!
        : (user?.roles?.firstOrNull ?? unknown);

    final rows = <(String, String)>[
      (AppStrings.driverProfilePhone, user?.phone ?? unknown),
      (AppStrings.driverProfileEmail, user?.email ?? unknown),
      (AppStrings.driverProfileRole, role),
      (AppStrings.driverProfileDriverId, user?.driverId ?? unknown),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < rows.length; i++) ...[
              DriverProfileInfoRowWidget(
                label: rows[i].$1,
                value: rows[i].$2,
              ),
              if (i != rows.length - 1) const DashboardDividerWidget(),
            ],
          ],
        ),
      ),
    ).animate().fadeIn(delay: 120.ms, duration: 320.ms).slideY(
      begin: 0.05,
      end: 0,
    );
  }
}
