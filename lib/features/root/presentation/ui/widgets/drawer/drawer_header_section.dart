import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/services/session/auth_manager.dart';

class DrawerHeaderSection extends StatelessWidget {
  const DrawerHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = getIt<AuthManager>().currentUser;
    final nameText =
        currentUser?.name?.trim().isNotEmpty == true
        ? currentUser!.name!
        : AppStrings.dashboardUnknownDriver;
    final phoneText = currentUser?.phone ?? '';

    return Padding(
      padding: REdgeInsets.fromLTRB(
        AppSpacing.xl,
        context.topPadding + AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64.r,
            height: 64.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.primary.withValues(alpha: 0.10),
              border: Border.all(
                color: context.onSurface.withValues(alpha: 0.08),
              ),
            ),
            child: currentUser?.profilePhotoUrl != null
                ? ClipOval(
                    child: AppImageViewer.network(
                      currentUser!.profilePhotoUrl!,
                      width: 64.r,
                      height: 64.r,
                      borderRadius: 0,
                    ),
                  )
                : Center(
                    child: FaIcon(
                      FontAwesomeIcons.solidUser,
                      size: 22.r,
                      color: context.primary,
                    ),
                  ),
          ),
          AppSpacing.md.verticalSpace,
          Text(
            nameText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.s20w700.copyWith(color: context.onSurface),
          ),
          if (phoneText.isNotEmpty) ...[
            AppSpacing.xs.verticalSpace,
            Text(
              phoneText,
              style: AppTextStyles.s12w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ],
          AppSpacing.lg.verticalSpace,
          Container(
            height: 1,
            color: context.onSurface.withValues(alpha: 0.06),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: -0.05, duration: 280.ms);
  }
}
