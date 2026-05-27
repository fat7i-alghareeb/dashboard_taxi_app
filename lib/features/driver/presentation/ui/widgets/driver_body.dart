import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/services/session/auth_manager.dart';
import 'package:dashboardtaxi/features/auth/presentation/ui/widgets/auth_header_widget.dart';
import 'package:dashboardtaxi/features/driver/presentation/ui/widgets/driver_profile_header_widget.dart';
import 'package:dashboardtaxi/features/driver/presentation/ui/widgets/driver_profile_info_section.dart';

class DriverBody extends StatelessWidget {
  const DriverBody({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getIt<AuthManager>().currentUser;

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.xl,
      ),
      children: [
        AuthHeaderWidget(
          title: AppStrings.driverProfileTitle,
          subtitle: AppStrings.driverProfileSubtitle,
          onBack: () => context.pop(),
        ),
        AppSpacing.xxl.verticalSpace,
        DriverProfileHeaderWidget(user: user),
        AppSpacing.xxl.verticalSpace,
        DriverProfileInfoSection(user: user),
        AppSpacing.xl.verticalSpace,
        AppButton.outline(
          layout: const AppButtonLayout(height: 48, borderRadius: AppRadii.lg),
          onTap: () async {
            await getIt<AuthManager>().logout();
          },
          child: AppButtonChild.labelIcon(
            label: AppStrings.logout,
            icon: IconSource.icon(FontAwesomeIcons.rightFromBracket),
            iconSize: 14.r,
            textStyle: AppTextStyles.s14w600.copyWith(color: AppColors.error),
          ),
        ).animate().fadeIn(delay: 240.ms, duration: 320.ms),
      ],
    );
  }
}
