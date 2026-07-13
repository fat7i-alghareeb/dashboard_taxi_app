import 'package:flutter/services.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';

class RefundInfoRowWidget extends StatelessWidget {
  const RefundInfoRowWidget({
    super.key,
    required this.label,
    required this.value,
    this.copyable = false,
  });

  final String label;
  final String value;
  final bool copyable;

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
        if (copyable) ...[
          AppSpacing.xs.horizontalSpace,
          InkWell(
            borderRadius: BorderRadius.circular(AppRadii.sm.r),
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: value));
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(AppStrings.refundsIdCopied)));
              }
            },
            child: Padding(
              padding: REdgeInsets.all(AppSpacing.xs),
              child: FaIcon(
                FontAwesomeIcons.copy,
                size: 13.r,
                color: context.onSurface.withValues(alpha: 0.54),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
