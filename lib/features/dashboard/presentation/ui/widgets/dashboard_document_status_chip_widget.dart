import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardDocumentStatusChipWidget extends StatelessWidget {
  const DashboardDocumentStatusChipWidget({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final normalized = status.toLowerCase();
    final color = switch (normalized) {
      'approved' => AppColors.success,
      'rejected' => AppColors.error,
      _ => AppColors.warning,
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.xs.r),
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          status,
          style: AppTextStyles.s12w400.copyWith(color: color),
        ),
      ),
    );
  }
}
