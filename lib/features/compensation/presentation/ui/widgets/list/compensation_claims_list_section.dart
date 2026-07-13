import 'package:dashboardtaxi/common/imports/imports.dart';

import '../../../../domain/entities/compensation_claim_entity.dart';
import 'compensation_claim_card_widget.dart';

class CompensationClaimsListSection extends StatelessWidget {
  const CompensationClaimsListSection({
    super.key,
    required this.claims,
    required this.isReviewing,
  });

  final List<CompensationClaimEntity> claims;
  final bool isReviewing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < claims.length; index++) ...[
          if (index > 0) AppSpacing.md.verticalSpace,
          CompensationClaimCardWidget(
                claim: claims[index],
                isReviewing: isReviewing,
              )
              .animate(delay: (index * 35).ms)
              .fadeIn(duration: 220.ms)
              .slideY(begin: 0.04, end: 0),
        ],
      ],
    );
  }
}
