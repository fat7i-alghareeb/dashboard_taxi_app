import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/chat/presentation/ui/widgets/chat_entry_button.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:url_launcher/url_launcher.dart';

/// Shows the trip's passenger name and a tappable phone number.
/// Tapping the phone opens the device dialer (`tel:` URL).
///
/// Renders nothing when both fields are absent — sheets stay clean for
/// trips that don't have passenger contact data attached.
class TripCustomerContactWidget extends StatelessWidget {
  const TripCustomerContactWidget({super.key, required this.trip});

  final TripEntity trip;

  @override
  Widget build(BuildContext context) {
    final name = trip.passengerName?.trim();
    final phone = trip.passengerPhone?.trim();

    final hasName = name != null && name.isNotEmpty;
    final hasPhone = phone != null && phone.isNotEmpty;

    if (!hasName && !hasPhone) return const SizedBox.shrink();

    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: context.primary.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.user,
                size: 14.r,
                color: context.primary,
              ),
            ),
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.tripCustomerSectionTitle.toUpperCase(),
                  style: AppTextStyles.s11w500.copyWith(
                    color: context.onSurface.withValues(alpha: 0.55),
                    letterSpacing: 1.2,
                  ),
                ),
                if (hasName) ...[
                  2.verticalSpace,
                  Text(
                    name,
                    style: AppTextStyles.s14w600.copyWith(
                      color: context.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          if (!trip.status.isTerminal) ...[
            AppSpacing.sm.horizontalSpace,
            ChatEntryButton(
              tripId: trip.id,
              compact: true,
              customerName: trip.passengerName,
            ),
          ],
          if (hasPhone) ...[
            AppSpacing.sm.horizontalSpace,
            _CallButton(phone: phone),
          ],
        ],
      ),
    );
  }
}

class _CallButton extends StatelessWidget {
  const _CallButton({required this.phone});

  final String phone;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _callPhone(context, phone),
      borderRadius: BorderRadius.circular(AppRadii.md.r),
      child: Container(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppRadii.md.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.phone,
              size: 12.r,
              color: AppColors.success,
            ),
            AppSpacing.sm.horizontalSpace,
            Text(
              phone,
              style: AppTextStyles.s12w500.copyWith(color: AppColors.success),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _callPhone(BuildContext context, String number) async {
    final sanitized = number.replaceAll(RegExp(r'[^0-9+]'), '');
    final url = Uri.parse('tel:$sanitized');
    try {
      final ok = await launchUrl(url, mode: LaunchMode.externalApplication);
      if (!ok && context.mounted) {
        showErrorOverlay(context, AppStrings.tripCallCustomerFailed);
      }
    } catch (_) {
      if (context.mounted) {
        showErrorOverlay(context, AppStrings.tripCallCustomerFailed);
      }
    }
  }
}
