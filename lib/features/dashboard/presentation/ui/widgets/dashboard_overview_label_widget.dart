import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardOverviewLabelWidget extends StatelessWidget {
  const DashboardOverviewLabelWidget({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(left: AppSpacing.xs),
      child: Text(
        label.toUpperCase(),
        style: AppTextStyles.s11w500.copyWith(
          color: context.onSurface.withValues(alpha: 0.55),
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
