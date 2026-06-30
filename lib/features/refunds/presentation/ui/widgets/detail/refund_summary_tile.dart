import 'package:dashboardtaxi/common/imports/imports.dart';

class RefundSummaryTile extends StatelessWidget {
  const RefundSummaryTile({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154.w,
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: context.onSurface.withValues(alpha: 0.06),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.s11w500.copyWith(
              color: context.onSurface.withValues(alpha: 0.56),
            ),
          ),
          AppSpacing.xs.verticalSpace,
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.s12w500.copyWith(color: context.onSurface),
          ),
        ],
      ),
    );
  }
}
