import 'package:dashboardtaxi/common/imports/imports.dart';

class RefundDetailShimmerWidget extends StatelessWidget {
  const RefundDetailShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppShimmer.box(
          width: double.infinity,
          height: 178,
          borderRadius: AppRadii.lg,
        ),
        AppSpacing.lg.verticalSpace,
        AppShimmer.box(
          width: double.infinity,
          height: 118,
          borderRadius: AppRadii.lg,
        ),
        AppSpacing.lg.verticalSpace,
        ...List.generate(
          4,
          (index) => Padding(
            padding: REdgeInsets.only(bottom: AppSpacing.lg),
            child: AppShimmer.box(
              width: double.infinity,
              height: 176,
              borderRadius: AppRadii.lg,
            ),
          ),
        ),
      ],
    );
  }
}
