import 'package:flutter/services.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class StopAddressActionsWidget extends StatelessWidget {
  const StopAddressActionsWidget({
    super.key,
    required this.address,
    this.latitude,
    this.longitude,
    this.highlight = false,
  });

  final String address;
  final double? latitude;
  final double? longitude;
  final bool highlight;

  bool get _hasLocation => latitude != null && longitude != null;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StopAddressActionButton(
          tooltip: AppStrings.copyAddress,
          icon: FontAwesomeIcons.copy,
          highlight: highlight,
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: address));
            if (context.mounted) {
              showSuccessOverlay(context, AppStrings.addressCopied);
            }
          },
        ),
        if (_hasLocation) ...[
          AppSpacing.xs.horizontalSpace,
          _StopAddressActionButton(
            tooltip: AppStrings.openInGoogleMaps,
            icon: FontAwesomeIcons.mapLocationDot,
            highlight: highlight,
            onTap: () async {
              final url = Uri.parse(
                'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
              );
              final didLaunch = await launchUrl(
                url,
                mode: LaunchMode.externalApplication,
              );
              if (!didLaunch && context.mounted) {
                showErrorOverlay(context, AppStrings.couldNotOpenMap);
              }
            },
          ),
        ],
      ],
    );
  }
}

class _StopAddressActionButton extends StatelessWidget {
  const _StopAddressActionButton({
    required this.tooltip,
    required this.icon,
    required this.onTap,
    required this.highlight,
  });

  final String tooltip;
  final FaIconData icon;
  final VoidCallback onTap;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final foreground = highlight
        ? context.primary
        : context.onSurface.withValues(alpha: 0.62);
    final background = highlight
        ? context.primary.withValues(alpha: 0.12)
        : context.onSurface.withValues(alpha: 0.05);

    return Tooltip(
      message: tooltip,
      child: SizedBox(
        width: 34.r,
        height: 34.r,
        child: Material(
          color: background,
          borderRadius: BorderRadius.circular(AppRadii.md.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadii.md.r),
            onTap: onTap,
            child: Center(
              child: FaIcon(icon, color: foreground, size: 14.r),
            ),
          ),
        ),
      ),
    );
  }
}
