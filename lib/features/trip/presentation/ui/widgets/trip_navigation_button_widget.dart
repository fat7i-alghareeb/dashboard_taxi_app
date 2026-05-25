import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class TripNavigationButtonWidget extends StatelessWidget {
  const TripNavigationButtonWidget({super.key, required this.stop});

  final TripStopEntity? stop;

  @override
  Widget build(BuildContext context) {
    return AppButton.outline(
      variant: AppButtonVariant.success,
      isActive: stop != null,
      onTap: () => _openNavigation(context),
      onTapWhenInactive: () {
        showErrorOverlay(context, AppStrings.tripUnknownAddress);
      },
      child: AppButtonChild.labelIcon(
        label: AppStrings.tripNavigate,
        icon: IconSource.widget(
          FaIcon(FontAwesomeIcons.diamondTurnRight, size: 16.r),
          size: 16,
        ),
        textStyle: AppTextStyles.s14w400.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Future<void> _openNavigation(BuildContext context) async {
    final target = stop;
    if (target == null) return;

    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${target.latitude},${target.longitude}&travelmode=driving',
    );

    final opened = await launchUrl(url, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      showErrorOverlay(context, AppStrings.somethingWentWrong);
    }
  }
}
