import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardDividerWidget extends StatelessWidget {
  const DashboardDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: context.onSurface.withValues(alpha: 0.06),
    );
  }
}
