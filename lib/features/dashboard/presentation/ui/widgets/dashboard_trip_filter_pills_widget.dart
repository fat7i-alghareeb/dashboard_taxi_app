import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_filter.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_filter_pill_widget.dart';

class DashboardTripFilterPillsWidget extends StatelessWidget {
  const DashboardTripFilterPillsWidget({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final DashboardTripFilter selected;
  final ValueChanged<DashboardTripFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          for (int i = 0; i < DashboardTripFilter.values.length; i++) ...[
            if (i != 0) AppSpacing.sm.horizontalSpace,
            DashboardTripFilterPillWidget(
              label: DashboardTripFilter.values[i].label(),
              isSelected: DashboardTripFilter.values[i] == selected,
              onTap: () => onChanged(DashboardTripFilter.values[i]),
            ),
          ],
        ],
      ),
    );
  }
}
