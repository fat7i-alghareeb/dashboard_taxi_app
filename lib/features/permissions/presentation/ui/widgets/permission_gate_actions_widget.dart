import 'package:dashboardtaxi/common/imports/imports.dart';

class PermissionGateActionsWidget extends StatelessWidget {
  const PermissionGateActionsWidget({
    super.key,
    required this.onOpenSettings,
    required this.onRetry,
  });

  final Future<void> Function() onOpenSettings;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton.primaryGradient(
          onTap: () => onOpenSettings(),
          child: AppButtonChild.label(AppStrings.permissionGateOpenSettings),
        ),
        AppSpacing.md.verticalSpace,
        AppButton.grey(
          onTap: () => onRetry(),
          child: AppButtonChild.label(AppStrings.permissionGateTryAgain),
        ),
      ],
    );
  }
}
