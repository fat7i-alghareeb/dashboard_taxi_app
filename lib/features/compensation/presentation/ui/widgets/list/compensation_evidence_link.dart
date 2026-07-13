import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class CompensationEvidenceLink extends StatelessWidget {
  const CompensationEvidenceLink({
    super.key,
    required this.url,
    required this.index,
  });

  final String url;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final uri = Uri.tryParse(url);
        if (uri == null) return;
        final opened = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        if (!opened && context.mounted) {
          showErrorOverlay(context, AppStrings.somethingWentWrong);
        }
      },
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.paperclip,
              size: 12.r,
              color: context.primary,
            ),
            AppSpacing.sm.horizontalSpace,
            Expanded(
              child: Text(
                AppStrings.compensationEvidenceItem.trParams({
                  'index': index,
                }),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s12w500.copyWith(color: context.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
