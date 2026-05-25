import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/services/session/auth_manager.dart';

class DrawerHeaderSection extends StatelessWidget {
  const DrawerHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = getIt<AuthManager>().currentUser;
    final nameText = currentUser?.name ?? 'Adam';
    final phoneText = currentUser?.phone ?? '+31 6 12345678';

    return Padding(
      padding: REdgeInsets.fromLTRB(
        AppSpacing.xl,
        context.topPadding + AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.lg,
      ),
      child: Row(
        children: [
          // Profile Image wrapped in circular primary-colored border
          Container(
            padding: REdgeInsets.all(AppSpacing.xs.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.primary, width: 1.5.r),
            ),
            child: currentUser?.profilePhotoUrl != null
                ? ClipOval(
                    child: AppImageViewer.network(
                      currentUser!.profilePhotoUrl!,
                      width: 72.r,
                      height: 72.r,
                      borderRadius: 0,
                    ),
                  )
                : Container(
                    width: 72.r,
                    height: 72.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.primary.withValues(alpha: 0.1),
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.solidUser,
                        size: 28.r,
                        color: context.primary,
                      ),
                    ),
                  ),
          ),
          AppSpacing.md.horizontalSpace,
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      nameText,
                      style: AppTextStyles.s24w700.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                  ],
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  phoneText,
                  style: AppTextStyles.s16w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: -0.1);
  }
}
