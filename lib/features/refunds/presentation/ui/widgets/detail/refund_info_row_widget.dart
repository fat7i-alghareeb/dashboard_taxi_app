import 'package:dashboardtaxi/common/imports/imports.dart';

class RefundInfoRowWidget extends StatelessWidget {
  const RefundInfoRowWidget({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 138.w,
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.58),
            ),
          ),
        ),
        AppSpacing.md.horizontalSpace,
        Expanded(
          child: SelectableText(
            value,
            textAlign: TextAlign.end,
            style: AppTextStyles.s12w500.copyWith(color: context.onSurface),
          ),
        ),
      ],
    );
  }
}
