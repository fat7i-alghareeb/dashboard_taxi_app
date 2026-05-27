import 'package:dashboardtaxi/common/imports/imports.dart';

class PermissionGateLoadingSection extends StatelessWidget {
  const PermissionGateLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MainLoadingProgress(),
          AppSpacing.lg.verticalSpace,
          Text(
            AppStrings.permissionGateLoading,
            textAlign: TextAlign.center,
            style: AppTextStyles.s16w600.copyWith(color: context.onSurface),
          ),
        ],
      ),
    );
  }
}
