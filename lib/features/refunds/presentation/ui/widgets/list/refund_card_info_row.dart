import 'package:dashboardtaxi/common/imports/imports.dart';

class RefundCardInfoRow extends StatelessWidget {
  const RefundCardInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 126.w,
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: AppTextStyles.s12w500.copyWith(color: context.onSurface),
          ),
        ),
      ],
    );
  }
}
