import 'package:dashboardtaxi/common/imports/imports.dart';

class RefundsShimmerWidget extends StatelessWidget {
  const RefundsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) => Padding(
          padding: REdgeInsets.only(bottom: AppSpacing.md),
          child: AppShimmer.box(
            width: double.infinity,
            height: 168,
            borderRadius: AppRadii.lg,
          ),
        ),
      ),
    );
  }
}
