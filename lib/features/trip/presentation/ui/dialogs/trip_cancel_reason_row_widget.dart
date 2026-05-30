import 'package:dashboardtaxi/common/imports/imports.dart';

class TripCancelReasonRowWidget extends StatelessWidget {
  const TripCancelReasonRowWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? context.primary
        : context.onSurface.withValues(alpha: 0.10);
    final bgColor = isSelected
        ? context.primary.withValues(alpha: 0.06)
        : Colors.transparent;

    return Material(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
        side: BorderSide(color: borderColor),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
        child: Padding(
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Container(
                width: 16.r,
                height: 16.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? context.primary : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? context.primary
                        : context.onSurface.withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 6.r,
                          height: 6.r,
                          decoration: BoxDecoration(
                            color: context.onSurface,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.s14w500.copyWith(
                    color: context.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
