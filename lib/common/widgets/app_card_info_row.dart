import 'package:dashboardtaxi/common/imports/imports.dart';

/// Shared label/value row used inside admin review-queue cards.
class AppCardInfoRow extends StatelessWidget {
  const AppCardInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.labelWidth = 126,
    this.valueMaxLines = 1,
  });

  final String label;
  final String value;
  final double labelWidth;
  final int valueMaxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: labelWidth.w,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.58),
            ),
          ),
        ),
        AppSpacing.sm.horizontalSpace,
        Expanded(
          child: Text(
            value,
            maxLines: valueMaxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: AppTextStyles.s12w500.copyWith(color: context.onSurface),
          ),
        ),
      ],
    );
  }
}
