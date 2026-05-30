import 'package:dashboardtaxi/common/imports/imports.dart';

/// A labelled text field paired with its own save button, used for the
/// pricing fields. Each field persists independently so a save only loads
/// its own control.
class ControlCenterInlineField extends StatelessWidget {
  const ControlCenterInlineField({
    super.key,
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.isSaving,
    required this.onSave,
    this.icon,
    this.suffix,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isSaving;
  final VoidCallback onSave;
  final IconData? icon;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    final isNumeric =
        keyboardType.decimal == true ||
        keyboardType == TextInputType.number ||
        keyboardType == const TextInputType.numberWithOptions(decimal: true);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    FaIcon(
                      icon,
                      size: 11.r,
                      color: context.onSurface.withValues(alpha: 0.55),
                    ),
                    AppSpacing.xs.horizontalSpace,
                  ],
                  Text(
                    label,
                    style: AppTextStyles.s12w500.copyWith(
                      color: context.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
              AppSpacing.xs.verticalSpace,
              TextField(
                controller: controller,
                keyboardType: keyboardType,
                inputFormatters: [
                  if (isNumeric) const ArabicToEnglishDigitsFormatter(),
                ],
                style: AppTextStyles.s14w400.copyWith(color: context.onSurface),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: REdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.md,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.md.r),
                    borderSide: BorderSide(
                      color: context.onSurface.withValues(alpha: 0.12),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.md.r),
                    borderSide: BorderSide(
                      color: context.onSurface.withValues(alpha: 0.08),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.md.r),
                    borderSide: BorderSide(color: context.primary, width: 1.5.w),
                  ),
                  suffixText: suffix,
                  suffixStyle: AppTextStyles.s14w500.copyWith(
                    color: context.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
        AppSpacing.md.horizontalSpace,
        SizedBox(
          width: 92.w,
          child: AppButton.primary(
            isLoading: isSaving,
            layout: const AppButtonLayout(height: 44),
            onTap: onSave,
            child: AppButtonChild.label(
              AppStrings.settingsSaveLabel,
              textStyle: AppTextStyles.s12w500,
            ),
          ),
        ),
      ],
    );
  }
}
