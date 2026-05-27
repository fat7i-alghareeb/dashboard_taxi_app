import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/kyc/presentation/states/kyc_bloc.dart';
import 'package:dashboardtaxi/features/kyc/presentation/ui/widgets/kyc_status_panel_widget.dart';

class KycReviewLockSection extends StatelessWidget {
  const KycReviewLockSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycBloc, KycState>(
      builder: (context, state) {
        return KycStatusPanelWidget(
          tone: AppColors.warning,
          title: AppStrings.kycUnderReviewTitle,
          subtitle: AppStrings.kycUnderReviewSubtitle,
          actionLabel: AppStrings.retry,
          isLoading: state.refreshState.isLoading,
          onTap: () {
            context.read<KycBloc>().add(
              const KycEvent.refreshStatusRequested(),
            );
          },
        );
      },
    );
  }
}
