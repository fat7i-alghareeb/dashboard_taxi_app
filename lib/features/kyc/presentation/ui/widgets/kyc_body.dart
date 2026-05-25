import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/services/session/auth_state_notifier.dart';
import 'kyc_pending_section.dart';
import 'kyc_review_lock_section.dart';
import 'kyc_suspended_section.dart';

class KycBody extends StatelessWidget {
  const KycBody({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = getIt<AuthStateNotifier>();

    return ListenableBuilder(
      listenable: authState,
      builder: (context, _) {
        final approvalStatus = authState.user?.approvalStatus ?? 'PendingDocuments';

        switch (approvalStatus) {
          case 'UnderReview':
            return const KycReviewLockSection();
          case 'Suspended':
            return const KycSuspendedSection();
          case 'PendingDocuments':
          default:
            return const KycPendingSection();
        }
      },
    );
  }
}
