import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:url_launcher/url_launcher.dart';

class TripStopRowWidget extends StatelessWidget {
  const TripStopRowWidget({
    super.key,
    required this.label,
    required this.value,
    required this.isPickup,
    required this.isLast,
    this.isCompleted = false,
    this.isNext = false,
    this.latitude,
    this.longitude,
  });

  final String label;
  final String value;
  final bool isPickup;
  final bool isLast;
  final bool isCompleted;
  final bool isNext;
  final double? latitude;
  final double? longitude;

  @override
  Widget build(BuildContext context) {
    final dotColor = isCompleted
        ? AppColors.success
        : isNext
            ? context.primary
            : context.onSurface.withValues(alpha: 0.45);

    final lineColor = isCompleted
        ? AppColors.success.withValues(alpha: 0.4)
        : context.onSurface.withValues(alpha: 0.15);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10.r,
                height: 10.r,
                margin: REdgeInsets.only(top: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5.r,
                    margin: REdgeInsets.symmetric(vertical: AppSpacing.xs / 2),
                    color: lineColor,
                  ),
                ),
            ],
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Padding(
              padding: REdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label.toUpperCase(),
                          style: AppTextStyles.s11w500.copyWith(
                            color: isNext
                                ? context.primary
                                : context.onSurface.withValues(alpha: 0.50),
                            fontWeight: isNext ? FontWeight.w700 : FontWeight.w500,
                            letterSpacing: 1.1,
                          ),
                        ),
                        AppSpacing.xs.verticalSpace,
                        Text(
                          value,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s14w500.copyWith(
                            color: context.onSurface,
                            fontWeight: isNext ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (latitude != null && longitude != null) ...[
                    AppSpacing.sm.horizontalSpace,
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadii.md.r),
                        child: Material(
                          color: isNext
                              ? context.primary.withValues(alpha: 0.12)
                              : context.onSurface.withValues(alpha: 0.05),
                          child: InkWell(
                            onTap: () async {
                              final url = Uri.parse(
                                  'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              }
                            },
                            child: Padding(
                              padding: REdgeInsets.all(AppSpacing.sm),
                              child: FaIcon(
                                FontAwesomeIcons.mapLocationDot,
                                color: isNext
                                    ? context.primary
                                    : context.onSurface.withValues(alpha: 0.6),
                                size: 16.r,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
