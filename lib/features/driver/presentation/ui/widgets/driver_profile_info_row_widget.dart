import 'package:dashboardtaxi/common/imports/imports.dart';

class DriverProfileInfoRowWidget extends StatelessWidget {
  const DriverProfileInfoRowWidget({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label.toUpperCase(),
              style: AppTextStyles.s11w500.copyWith(
                color: context.onSurface.withValues(alpha: 0.50),
                letterSpacing: 1.1,
              ),
            ),
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s14w500.copyWith(color: context.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}
