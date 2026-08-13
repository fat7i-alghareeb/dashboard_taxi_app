import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';

import '../../states/profile_bloc.dart';

class ProfileDeleteAccountButton extends StatelessWidget {
  const ProfileDeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listenWhen: (prev, curr) =>
          prev.deleteAccountStatus != curr.deleteAccountStatus,
      listener: (context, state) {
        if (state.deleteAccountStatus.isSuccess) {
          showSuccessOverlay(context, AppStrings.profileDeleteAccountSuccess);
        } else if (state.deleteAccountStatus.isFailed) {
          final message = state.deleteAccountStatus.errorMessage;
          showErrorOverlay(
            context,
            message?.isNotEmpty == true
                ? message!
                : AppStrings.profileDeleteAccountFailure,
          );
        }
      },
      builder: (context, state) {
        return AppButton.outline(
          variant: const CustomButtonVariant(
            color: AppColors.error,
            foregroundColor: AppColors.error,
          ),
          isLoading: state.deleteAccountStatus.isLoading,
          onTap: () => _confirmAndDelete(context),
          child: AppButtonChild.labelIcon(
            label: AppStrings.profileDeleteAccount,
            icon: IconSource.widget(
              FaIcon(FontAwesomeIcons.trashCan, size: 14.r),
              size: 14,
            ),
          ),
        ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.05);
      },
    );
  }

  Future<void> _confirmAndDelete(BuildContext context) async {
    final bloc = context.read<ProfileBloc>();
    final confirmed = await AppDialog.show<bool>(
      context,
      dialog: AppDialog.basic(
        icon: IconSource.widget(
          FaIcon(FontAwesomeIcons.triangleExclamation, size: 22.r),
          size: 22,
        ),
        title: AppStrings.profileDeleteAccountDialogTitle,
        message: AppStrings.profileDeleteAccountDialogMessage,
        primaryAction: AppDialogAction.danger(
          label: AppStrings.profileDeleteAccountConfirm,
          onPressed: () => Navigator.pop(context, true),
        ),
        secondaryAction: AppDialogAction.secondary(
          label: AppStrings.cancel,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
    );

    if (confirmed == true) {
      bloc.add(ProfileDeleteAccountRequested());
    }
  }
}
