import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';

class DashboardAdminProfileSection extends StatelessWidget {
  const DashboardAdminProfileSection({super.key, required this.profile});

  final DashboardAdminProfileEntity? profile;

  @override
  Widget build(BuildContext context) {
    if (profile == null) {
      return const SizedBox.shrink();
    }

    final admin = profile!;
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardAdminProfile,
      subtitle: AppStrings.dashboardAdminProfileSubtitle,
      icon: FontAwesomeIcons.userShield,
      child: Wrap(
        spacing: AppSpacing.md.w,
        runSpacing: AppSpacing.md.h,
        children: [
          _AdminProfileInfoTile(
            label: AppStrings.profileName,
            value: admin.name,
          ),
          _AdminProfileInfoTile(
            label: AppStrings.dashboardAdminEmail,
            value: admin.email,
          ),
          _AdminProfileInfoTile(
            label: AppStrings.dashboardAdminPhone1,
            value: admin.phone1 ?? AppStrings.dashboardNotProvided,
          ),
          _AdminProfileInfoTile(
            label: AppStrings.dashboardAdminPhone2,
            value: admin.phone2 ?? AppStrings.dashboardNotProvided,
          ),
        ],
      ),
    );
  }
}

class _AdminProfileInfoTile extends StatelessWidget {
  const _AdminProfileInfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 148.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.s12w500.copyWith(
              color: context.onSurface.withValues(alpha: 0.55),
            ),
          ),
          AppSpacing.xs.verticalSpace,
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.s14w600.copyWith(color: context.onSurface),
          ),
        ],
      ),
    );
  }
}
