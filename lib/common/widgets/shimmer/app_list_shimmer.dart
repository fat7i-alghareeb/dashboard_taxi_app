import 'package:dashboardtaxi/common/imports/imports.dart';

/// Shared loading skeleton for card-list screens: a column of shimmering
/// rounded boxes standing in for cards while data loads.
class AppListShimmer extends StatelessWidget {
  const AppListShimmer({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 168,
    this.borderRadius = AppRadii.lg,
  });

  final int itemCount;
  final double itemHeight;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (index) => Padding(
          padding: REdgeInsets.only(bottom: AppSpacing.md),
          child: AppShimmer.box(
            width: double.infinity,
            height: itemHeight,
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}
