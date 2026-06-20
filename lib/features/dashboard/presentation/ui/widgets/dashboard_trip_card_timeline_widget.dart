import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';

/// Compact horizontal status/time stepper shown inside a trip card.
/// Each reached stage shows its real timestamp; unreached stages are dimmed.
class DashboardTripCardTimelineWidget extends StatelessWidget {
  const DashboardTripCardTimelineWidget({super.key, required this.trip});

  final DashboardTripEntity trip;

  @override
  Widget build(BuildContext context) {
    final steps = <(String, DateTime?)>[
      (AppStrings.tripCreatedAt, trip.createdAt),
      if (trip.scheduledAt != null)
        (AppStrings.tripStatusScheduled, trip.scheduledAt),
      (AppStrings.dashboardAssignedAt, trip.acceptedAt ?? trip.assignedAt),
      (AppStrings.dashboardArrivedAt, trip.arrivedAt),
      (AppStrings.dashboardStartedAt, trip.startedAt),
      (AppStrings.dashboardCompletedAt, trip.completedAt),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < steps.length; i++)
          Expanded(
            child: _TimelineStep(
              label: steps[i].$1,
              time: steps[i].$2,
              isFirst: i == 0,
              isLast: i == steps.length - 1,
            ),
          ),
      ],
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.label,
    required this.time,
    required this.isFirst,
    required this.isLast,
  });

  final String label;
  final DateTime? time;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isComplete = time != null;
    final dotColor = isComplete
        ? AppColors.success
        : context.onSurface.withValues(alpha: 0.25);
    final lineColor = context.onSurface.withValues(alpha: 0.15);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1.5.r,
                color: isFirst ? Colors.transparent : lineColor,
              ),
            ),
            Container(
              width: 10.r,
              height: 10.r,
              decoration: BoxDecoration(
                color: isComplete ? AppColors.success : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: dotColor, width: 1.5),
              ),
            ),
            Expanded(
              child: Container(
                height: 1.5.r,
                color: isLast ? Colors.transparent : lineColor,
              ),
            ),
          ],
        ),
        AppSpacing.xs.verticalSpace,
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppTextStyles.s11w500.copyWith(
            color: context.onSurface.withValues(
              alpha: isComplete ? 0.80 : 0.45,
            ),
          ),
        ),
        Text(
          time == null ? AppStrings.dashboardNotReached : _formatTime(time!),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppTextStyles.s11w500.copyWith(
            color: context.onSurface.withValues(
              alpha: isComplete ? 0.60 : 0.30,
            ),
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime utc) {
    final local = utc.toLocal();
    final h = local.hour.toString().padLeft(2, '0');
    final m = local.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
