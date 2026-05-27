import '../../imports/imports.dart';

class EmptyStateBadgeWidget extends StatelessWidget {
  const EmptyStateBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.r,
      height: 4.r,
      decoration: BoxDecoration(
        color: context.onSurface.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(AppRadii.xs.r),
      ),
    );
  }
}
