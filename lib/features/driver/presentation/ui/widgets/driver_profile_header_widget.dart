import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/domain/user_entity.dart';

class DriverProfileHeaderWidget extends StatelessWidget {
  const DriverProfileHeaderWidget({super.key, required this.user});

  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    final name = user?.name?.trim().isNotEmpty == true
        ? user!.name!
        : AppStrings.dashboardUnknownDriver;
    final phone = user?.phone ?? '';
    final photoUrl = user?.profilePhotoUrl;

    return Column(
      children: [
        Container(
          width: 80.r,
          height: 80.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.primary.withValues(alpha: 0.10),
            border: Border.all(
              color: context.onSurface.withValues(alpha: 0.08),
            ),
          ),
          child: photoUrl != null && photoUrl.isNotEmpty
              ? ClipOval(
                  child: AppImageViewer.network(
                    photoUrl,
                    width: 80.r,
                    height: 80.r,
                    borderRadius: 0,
                  ),
                )
              : Center(
                  child: FaIcon(
                    FontAwesomeIcons.solidUser,
                    size: 28.r,
                    color: context.primary,
                  ),
                ),
        ),
        AppSpacing.md.verticalSpace,
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppTextStyles.s20w700.copyWith(color: context.onSurface),
        ),
        if (phone.isNotEmpty) ...[
          AppSpacing.xs.verticalSpace,
          Text(
            phone,
            textAlign: TextAlign.center,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.55),
            ),
          ),
        ],
      ],
    ).animate().fadeIn(duration: 320.ms).slideY(begin: 0.05, end: 0);
  }
}
