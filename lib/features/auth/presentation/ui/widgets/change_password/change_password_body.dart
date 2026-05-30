import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/auth/constants/forms/auth_forms.dart';
import 'package:dashboardtaxi/features/auth/presentation/states/admin_auth_bloc.dart';
import 'package:dashboardtaxi/features/auth/presentation/ui/widgets/auth_header_widget.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  final FormGroup _form = AuthForms.changePasswordFormGroup();

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_form.invalid) {
      _form.markAllAsTouched();
      return;
    }
    final currentPassword =
        _form.control(AuthForms.currentPasswordField).value as String?;
    final newPassword =
        _form.control(AuthForms.newPasswordField).value as String?;
    final confirmPassword =
        _form.control(AuthForms.confirmPasswordField).value as String?;

    if (newPassword != confirmPassword) {
      showErrorOverlay(context, AppStrings.passwordsDoNotMatch);
      return;
    }

    printC('[ChangePasswordBody] submit change password');
    context.read<AdminAuthBloc>().add(
      AdminChangePasswordRequested(
        currentPassword: currentPassword ?? '',
        newPassword: newPassword ?? '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminAuthBloc, AdminAuthState>(
      listenWhen: (previous, current) =>
          previous.changePasswordStatus != current.changePasswordStatus,
      listener: (context, state) {
        state.changePasswordStatus.maybeWhen(
          success: (_) {
            printG('[ChangePasswordBody] password change success observed');
            showSuccessOverlay(context, AppStrings.changePasswordSuccess);
            Navigator.maybePop(context);
          },
          failure: (message) {
            printY('[ChangePasswordBody] password change failed: $message');
            showErrorOverlay(context, message);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return ReactiveForm(
          formGroup: _form,
          child: AppScaffold.body(
            scaffoldConfig: AppScaffoldConfig(backgroundColor: context.surface),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: REdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.xl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AuthHeaderWidget(
                          title: AppStrings.changePasswordTitle,
                          subtitle: AppStrings.changePasswordSubtitle,
                          onBack: () => Navigator.maybePop(context),
                        ),
                        AppSpacing.xxl.verticalSpace,
                        AppReactiveTextField.password(
                          formControlName: AuthForms.currentPasswordField,
                          title: AppStrings.currentPassword,
                          hintText: AppStrings.currentPasswordHint,
                          textInputAction: TextInputAction.next,
                        ),
                        AppSpacing.lg.verticalSpace,
                        AppReactiveTextField.password(
                          formControlName: AuthForms.newPasswordField,
                          title: AppStrings.newPassword,
                          hintText: AppStrings.newPasswordHint,
                          textInputAction: TextInputAction.next,
                        ),
                        AppSpacing.lg.verticalSpace,
                        AppReactiveTextField.password(
                          formControlName: AuthForms.confirmPasswordField,
                          title: AppStrings.confirmPassword,
                          hintText: AppStrings.confirmPasswordHint,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_, _) => _submit(context),
                        ),
                        AppSpacing.xl.verticalSpace,
                        ReactiveFormConsumer(
                          builder: (context, form, child) {
                            final newPassword =
                                form.control(AuthForms.newPasswordField).value
                                    as String?;
                            final confirmPassword =
                                form
                                        .control(AuthForms.confirmPasswordField)
                                        .value
                                    as String?;
                            final passwordsMatch =
                                newPassword == confirmPassword;
                            final canSubmit = form.valid && passwordsMatch;

                            return AppButton.primary(
                              isActive: canSubmit,
                              isLoading: state.changePasswordStatus.isLoading,
                              layout: const AppButtonLayout(height: 52),
                              onTapWhenInactive: () {
                                if (!passwordsMatch) {
                                  printY(
                                    '[ChangePasswordBody] submit blocked '
                                    'passwords do not match',
                                  );
                                  showErrorOverlay(
                                    context,
                                    AppStrings.passwordsDoNotMatch,
                                  );
                                }
                              },
                              onTap: () => _submit(context),
                              child: AppButtonChild.label(
                                AppStrings.changePasswordSubmit,
                              ),
                            );
                          },
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
