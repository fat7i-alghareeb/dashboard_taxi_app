import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/detail/refund_info_row_widget.dart';

class RefundInfoRowData {
  const RefundInfoRowData(this.label, this.value);

  final String label;
  final String value;
}

class RefundDetailInfoSection extends StatelessWidget {
  const RefundDetailInfoSection({
    super.key,
    required this.title,
    required this.rows,
  });

  final String title;
  final List<RefundInfoRowData> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: context.onSurface.withValues(alpha: 0.08),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: AppTextStyles.s16w600.copyWith(color: context.onSurface),
          ),
          AppSpacing.md.verticalSpace,
          ...rows.map(
            (row) => Padding(
              padding: REdgeInsets.only(bottom: AppSpacing.sm),
              child: RefundInfoRowWidget(label: row.label, value: row.value),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 240.ms).slideY(begin: 0.04, end: 0);
  }
}
