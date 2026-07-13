import 'package:dashboardtaxi/common/imports/imports.dart';

import '../../states/compensation_cubit.dart';
import '../widgets/list/compensation_body.dart';

class CompensationClaimsScreen extends StatelessWidget {
  const CompensationClaimsScreen({super.key});

  static const String pagePath = '/compensation_claims';
  static const String pageName = 'CompensationClaimsScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.appBar(
      appBarConfig: AppScaffoldAppBarConfig(
        title: AppStrings.dashboardCompensationClaims,
        subtitle: AppStrings.compensationSubtitle,
        titleAlignment: AppScaffoldTitleAlignment.start,
      ),
      child: BlocProvider(
        create: (_) => getIt<CompensationCubit>()..loadClaims(),
        child: const CompensationBody(),
      ),
    );
  }
}
