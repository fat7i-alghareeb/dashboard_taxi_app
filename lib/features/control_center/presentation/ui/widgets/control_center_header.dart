import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';

/// Aurora-gradient hero header for the Control Center.
///
/// Shows the title, a short subtitle and two live fleet stats (total types /
/// active types) read from the vehicle-types section state.
class ControlCenterHeader extends StatelessWidget {
  const ControlCenterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.primary,
        borderRadius: BorderRadius.circular(AppRadii.xl.r),
        boxShadow: context.shadows.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _CircleAction(
                icon: context.chevronStart,
                onTap: () => context.pop(),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.controlCenter,
                      style: AppTextStyles.s22w700.copyWith(
                        color: context.onSurface,
                        height: 1.1,
                      ),
                    ),
                    AppSpacing.xs.verticalSpace,
                    Text(
                      AppStrings.controlCenterSubtitle,
                      style: AppTextStyles.s12w400.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.md.horizontalSpace,
              _CircleAction(
                icon: FontAwesomeIcons.arrowsRotate,
                onTap: () {
                  context.read<DashboardBloc>()
                    ..add(const DashboardEvent.adminConfigRequested())
                    ..add(const DashboardEvent.adminVehicleTypesRequested());
                },
              ),
            ],
          ),
          AppSpacing.lg.verticalSpace,
          BlocBuilder<DashboardBloc, DashboardState>(
            buildWhen: (prev, curr) =>
                prev.adminVehicleTypesState != curr.adminVehicleTypesState,
            builder: (context, state) {
              final types =
                  state.adminVehicleTypesState.getDataWhenSuccess ??
                  const <DashboardVehicleTypeEntity>[];
              final activeCount = types.where((t) => t.isActive).length;
              return Row(
                children: [
                  Expanded(
                    child: _StatChip(
                      value: types.length.toString(),
                      label: AppStrings.controlCenterTypes,
                    ),
                  ),
                  AppSpacing.md.horizontalSpace,
                  Expanded(
                    child: _StatChip(
                      value: activeCount.toString(),
                      label: AppStrings.settingsVehicleTypeActive,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 320.ms).slideY(begin: 0.05, end: 0);
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38.r,
        width: 38.r,
        decoration: BoxDecoration(
          color: context.surface.withValues(alpha: 0.18),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: FaIcon(icon, size: 15.r, color: context.onSurface),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: context.surface.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        border: Border.all(color: context.surface.withValues(alpha: 0.22)),
      ),
      child: Row(
        children: [
          Text(
            value,
            style: AppTextStyles.s20w700.copyWith(color: context.onSurface),
          ),
          AppSpacing.sm.horizontalSpace,
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s12w400.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
