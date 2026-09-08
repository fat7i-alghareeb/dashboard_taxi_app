import 'package:dashboardtaxi/common/imports/imports.dart';

/// Bordered row pairing a label (and optional supporting text) with an adaptive
/// switch bound to a `FormControl<bool>`.
///
/// Promoted out of `control_center_vehicle_type_form_sheet.dart` when
/// app_version_config became the second consumer (project rules S20, Global
/// Promotion Rule).
class AppReactiveSwitchTile extends StatelessWidget {
  const AppReactiveSwitchTile({
    super.key,
    required this.formControlName,
    required this.title,
    this.subtitle,
    this.defaultValue = true,
  });

  final String formControlName;
  final String title;
  final String? subtitle;

  /// Value shown while the control is still null, before the form is patched
  /// with loaded data.
  final bool defaultValue;

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        final control = form.control(formControlName) as FormControl<bool>;
        return Container(
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: context.surface,
            borderRadius: BorderRadius.circular(AppRadii.md.r),
            border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.s14w500.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                    if (subtitle != null) ...[
                      AppSpacing.xs.verticalSpace,
                      Text(
                        subtitle!,
                        style: AppTextStyles.s12w400.copyWith(
                          color: context.onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              AppSpacing.sm.horizontalSpace,
              Switch.adaptive(
                value: control.value ?? defaultValue,
                activeThumbColor: context.primary,
                onChanged: (v) => control.value = v,
              ),
            ],
          ),
        );
      },
    );
  }
}
