import 'package:dashboardtaxi/common/imports/imports.dart';

/// Shared selectable filter chip used across admin list/filter bars.
class AppFilterChipItem extends StatelessWidget {
  const AppFilterChipItem({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? context.primary : context.onSurface;
    return FilterChip(
      selected: selected,
      showCheckmark: false,
      label: Text(
        label,
        style: AppTextStyles.s12w500.copyWith(
          color: selected ? context.onPrimary : color.withValues(alpha: 0.72),
        ),
      ),
      onSelected: (_) => onSelected(),
      selectedColor: context.primary,
      backgroundColor: context.surfaceContainer,
      side: BorderSide(
        color: selected
            ? context.primary.withValues(alpha: 0.42)
            : context.onSurface.withValues(alpha: 0.08),
        width: 1.w,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
      ),
    );
  }
}
