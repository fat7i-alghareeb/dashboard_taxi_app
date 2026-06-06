import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardIconActionWidget extends StatelessWidget {
  const DashboardIconActionWidget({
    super.key,
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  final FaIconData icon;
  final VoidCallback onTap;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: context.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm.r),
          side: BorderSide(
            color: context.onSurface.withValues(alpha: 0.10),
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.sm.r),
          child: SizedBox(
            height: 40.r,
            width: 40.r,
            child: Center(
              child: FaIcon(
                icon,
                size: 14.r,
                color: context.onSurface.withValues(alpha: 0.78),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
