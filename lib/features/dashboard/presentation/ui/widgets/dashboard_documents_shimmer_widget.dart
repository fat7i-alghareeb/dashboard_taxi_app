import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardDocumentsShimmerWidget extends StatelessWidget {
  const DashboardDocumentsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        3,
        (index) => Padding(
          padding: REdgeInsets.only(bottom: AppSpacing.md),
          child: AppShimmer.box(width: double.infinity, height: 96),
        ),
      ),
    );
  }
}
