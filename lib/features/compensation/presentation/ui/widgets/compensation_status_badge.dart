import 'package:dashboardtaxi/common/imports/imports.dart';

import '../../../domain/entities/compensation_claim_entity.dart';

/// Status pill for a compensation claim, matching the refund / refund-request
/// badges' look. Colour + label derived from [CompensationClaimEntity.status].
class CompensationStatusBadge extends StatelessWidget {
  const CompensationStatusBadge({super.key, required this.claim});

  final CompensationClaimEntity claim;

  @override
  Widget build(BuildContext context) {
    final (color, label) = _resolve(context);
    return AppStatusBadge(color: color, label: label);
  }

  (Color, String) _resolve(BuildContext context) {
    switch (claim.status.trim().toLowerCase()) {
      case 'approved':
        return (AppColors.success, AppStrings.compensationStatusApproved);
      case 'rejected':
        return (context.error, AppStrings.compensationStatusRejected);
      case 'pending':
        return (AppColors.warning, AppStrings.compensationStatusPending);
      default:
        return (context.primary, claim.status);
    }
  }
}
