import 'package:dashboardtaxi/common/imports/imports.dart';

/// Wraps a row of [AppFilterChipItem]s with consistent spacing.
class AppFilterChipWrap extends StatelessWidget {
  const AppFilterChipWrap({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm.w,
      runSpacing: AppSpacing.sm.h,
      children: children,
    );
  }
}
