import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/control_center/presentation/ui/widgets/control_center_vehicle_type_form_sheet.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';

/// A single vehicle type, rendered as a self-contained card with status,
/// rate chips and inline management actions (activate toggle / edit / delete).
class ControlCenterVehicleTypeCard extends StatelessWidget {
  const ControlCenterVehicleTypeCard({
    super.key,
    required this.vehicleType,
    required this.isBusy,
  });

  final DashboardVehicleTypeEntity vehicleType;
  final bool isBusy;

  void _edit(BuildContext context) {
    if (isBusy) return;
    ControlCenterVehicleTypeFormSheet.show(context, initial: vehicleType);
  }

  Future<void> _delete(BuildContext context) async {
    if (isBusy) return;
    final confirm = await AppDialog.show<bool>(
      context,
      dialog: AppDialog.basic(
        title: AppStrings.settingsVehicleTypeDelete,
        message: AppStrings.settingsVehicleTypeDeleteConfirm,
        secondaryAction: AppDialogAction.secondary(
          label: AppStrings.cancel,
          onPressed: () => Navigator.pop(context, false),
        ),
        primaryAction: AppDialogAction.danger(
          label: AppStrings.settingsVehicleTypeDelete,
          onPressed: () => Navigator.pop(context, true),
        ),
      ),
    );
    if (confirm == true && context.mounted) {
      context.read<DashboardBloc>().add(
        DashboardEvent.vehicleTypeRemovalRequested(vehicleType.id),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final active = vehicleType.isActive;
    final statusColor = active ? AppColors.success : context.onSurface;

    return Opacity(
      opacity: isBusy ? 0.6 : 1,
      child: GestureDetector(
        onTap: () => _edit(context),
        child: Container(
          padding: REdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: context.onSurface.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(AppRadii.md.r),
            border: Border.all(
              color: active
                  ? AppColors.success.withValues(alpha: 0.25)
                  : context.onSurface.withValues(alpha: 0.08),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    height: 38.r,
                    width: 38.r,
                    decoration: BoxDecoration(
                      color: context.primary.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(AppRadii.sm.r),
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.carSide,
                        size: 14.r,
                        color: context.primary,
                      ),
                    ),
                  ),
                  AppSpacing.md.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicleType.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s14w600.copyWith(
                            color: context.onSurface,
                          ),
                        ),
                        AppSpacing.xs.verticalSpace,
                        Text(
                          vehicleType.code,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s12w400.copyWith(
                            color: context.onSurface.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.sm.horizontalSpace,
                  Container(
                    padding: REdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadii.xs.r),
                    ),
                    child: Text(
                      active
                          ? AppStrings.dashboardEnabled
                          : AppStrings.dashboardDisabled,
                      style: AppTextStyles.s11w500.copyWith(color: statusColor),
                    ),
                  ),
                ],
              ),
              AppSpacing.md.verticalSpace,
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  _Chip(
                    icon: FontAwesomeIcons.userGroup,
                    label: AppStrings.dashboardCapacityValue.replaceAll(
                      '{value}',
                      vehicleType.capacity.toString(),
                    ),
                  ),
                  _Chip(
                    icon: FontAwesomeIcons.route,
                    label:
                        '${vehicleType.ratePerKm.toStringAsFixed(2)}${AppStrings.controlCenterPerKm}',
                  ),
                  _Chip(
                    icon: FontAwesomeIcons.clock,
                    label:
                        '${vehicleType.ratePerMin.toStringAsFixed(2)}${AppStrings.controlCenterPerMin}',
                  ),
                  _Chip(
                    icon: FontAwesomeIcons.moneyBill,
                    label: AppStrings.dashboardMinFareValue.replaceAll(
                      '{value}',
                      vehicleType.minFare.toStringAsFixed(2),
                    ),
                  ),
                ],
              ),
              AppSpacing.md.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: Switch.adaptive(
                            value: active,
                            activeThumbColor: context.primary,
                            onChanged: isBusy
                                ? null
                                : (_) => context.read<DashboardBloc>().add(
                                    DashboardEvent
                                        .vehicleTypeStatusToggleRequested(
                                          vehicleType,
                                        ),
                                  ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            AppStrings.settingsVehicleTypeActive,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.s12w400.copyWith(
                              color: context.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _IconAction(
                    icon: FontAwesomeIcons.penToSquare,
                    color: context.primary,
                    onTap: () => _edit(context),
                  ),
                  AppSpacing.sm.horizontalSpace,
                  _IconAction(
                    icon: FontAwesomeIcons.trashCan,
                    color: AppColors.error,
                    onTap: () => _delete(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: context.onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            icon,
            size: 10.r,
            color: context.onSurface.withValues(alpha: 0.55),
          ),
          AppSpacing.xs.horizontalSpace,
          Text(
            label,
            style: AppTextStyles.s11w500.copyWith(
              color: context.onSurface.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  const _IconAction({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34.r,
        width: 34.r,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(AppRadii.sm.r),
        ),
        child: Center(child: FaIcon(icon, size: 13.r, color: color)),
      ),
    );
  }
}
