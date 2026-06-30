import 'package:dashboardtaxi/common/imports/imports.dart';

class RefundFilterChipWrap extends StatelessWidget {
  const RefundFilterChipWrap({super.key, required this.children});

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
