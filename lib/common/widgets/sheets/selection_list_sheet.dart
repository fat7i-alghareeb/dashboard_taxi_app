import 'package:flutter/services.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';

class SelectionItem<T> {
  const SelectionItem({
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final T value;
  final IconData? icon;
}

class SelectionListSheet<T> extends StatelessWidget {
  const SelectionListSheet({
    super.key,
    required this.title,
    required this.items,
    required this.selectedValue,
    required this.onSelected,
  });

  final String title;
  final List<SelectionItem<T>> items;
  final T selectedValue;
  final ValueChanged<T> onSelected;

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required List<SelectionItem<T>> items,
    required T selectedValue,
  }) {
    return AppBottomSheet.show<T>(
      context,
      sheet: AppBottomSheet.basic(
        title: title,
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.lg,
        ),
        child: SelectionListSheet<T>(
          title: title,
          items: items,
          selectedValue: selectedValue,
          onSelected: (value) => Navigator.pop(context, value),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: items.map((item) {
        final isSelected = item.value == selectedValue;

        return Padding(
          padding: REdgeInsets.only(bottom: AppSpacing.sm),
          child: InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              onSelected(item.value);
            },
            borderRadius: BorderRadius.circular(AppRadii.md.r),
            child: AnimatedContainer(
              duration: AppDurations.normal,
              padding: REdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: isSelected
                    ? context.primary.withValues(alpha: 0.08)
                    : context.surface,
                borderRadius: BorderRadius.circular(AppRadii.md.r),
                border: Border.all(
                  color: isSelected
                      ? context.primary.withValues(alpha: 0.5)
                      : context.theme.dividerColor.withValues(alpha: 0.05),
                  width: 1.5.r,
                ),
              ),
              child: Row(
                children: [
                  if (item.icon != null) ...[
                    FaIcon(
                      item.icon!,
                      size: 18.r,
                      color: isSelected ? context.primary : context.onSurface,
                    ),
                    AppSpacing.md.horizontalSpace,
                  ],
                  Expanded(
                    child: Text(
                      item.label,
                      style: AppTextStyles.s16w600.copyWith(
                        color: isSelected ? context.primary : context.onSurface,
                      ),
                    ),
                  ),
                  if (isSelected)
                    FaIcon(
                      FontAwesomeIcons.circleCheck,
                      size: 20.r,
                      color: context.primary,
                    ).animate().scale(duration: AppDurations.fast),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
