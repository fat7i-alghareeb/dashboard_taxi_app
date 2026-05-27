import 'package:dashboardtaxi/common/imports/imports.dart';

import 'permission_gate_actions_widget.dart';
import 'permission_gate_ui_state.dart';

class PermissionGateBlockedSection extends StatelessWidget {
  const PermissionGateBlockedSection({
    super.key,
    required this.state,
    required this.onOpenSettings,
    required this.onRetry,
  });

  final PermissionGateUiState state;
  final Future<void> Function() onOpenSettings;
  final Future<void> Function() onRetry;

  String _messageForState() {
    switch (state) {
      case PermissionGateUiState.denied:
        return AppStrings.permissionGateDeniedMessage;
      case PermissionGateUiState.permanentlyDenied:
        return AppStrings.permissionGatePermanentlyDeniedMessage;
      case PermissionGateUiState.locationServiceDisabled:
        return AppStrings.permissionGateServiceDisabledMessage;
      case PermissionGateUiState.loading:
        return AppStrings.permissionGateLoading;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: AppSpacing.standardPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.permissionGateTitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.s24w700.copyWith(color: context.onSurface),
            ),
            AppSpacing.md.verticalSpace,
            Text(
              AppStrings.permissionGateDescription,
              textAlign: TextAlign.center,
              style: AppTextStyles.s14w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.82),
              ),
            ),
            AppSpacing.md.verticalSpace,
            Text(
              _messageForState(),
              textAlign: TextAlign.center,
              style: AppTextStyles.s14w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.72),
              ),
            ),
            AppSpacing.xl.verticalSpace,
            PermissionGateActionsWidget(
              onOpenSettings: onOpenSettings,
              onRetry: onRetry,
            ),
            AppSpacing.lg.verticalSpace,
            Text(
              AppStrings.permissionGateBlockingHint,
              textAlign: TextAlign.center,
              style: AppTextStyles.s12w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.62),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
