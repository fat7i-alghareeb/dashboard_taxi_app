import 'package:dashboardtaxi/common/imports/imports.dart';

class RootMapRecenterButtonWidget extends StatelessWidget {
  const RootMapRecenterButtonWidget({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppButton.primary(
      onTap: onTap,
      layout: AppButtonLayout(
        borderRadius: AppRadii.md,
        height: 40,
        width: 40,
        contentPadding: REdgeInsets.all(AppSpacing.sm),
      ),
      child: AppButtonChild.icon(
        IconSource.builder(
          (context) =>
              FaIcon(FontAwesomeIcons.locationCrosshairs, size: 16.r),
        ),
      ),
    );
  }
}
