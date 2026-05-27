import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/auth/constants/forms/auth_forms.dart';
import 'package:dashboardtaxi/features/auth/presentation/states/auth_bloc.dart';
import 'package:dashboardtaxi/features/auth/presentation/ui/widgets/auth_header_widget.dart';

class ForcePasswordResetBody extends StatefulWidget {
  const ForcePasswordResetBody({super.key});

  @override
  State<ForcePasswordResetBody> createState() => _ForcePasswordResetBodyState();
}

class _ForcePasswordResetBodyState extends State<ForcePasswordResetBody> {
  final FormGroup _form = AuthForms.forceResetFormGroup();

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.forceResetStatus != current.forceResetStatus,
      listener: (context, state) {
        state.forceResetStatus.maybeWhen(
          success: (_) {
            printG('[ForcePasswordResetBody] reset success observed');
            showSuccessOverlay(context, AppStrings.passwordResetSuccess);
          },
          failure: (message) {
            printY('[ForcePasswordResetBody] reset failed: $message');
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
                          title: AppStrings.forcePasswordReset,
                          subtitle: AppStrings.forcePasswordResetSubtitle,
                        ),
                        AppSpacing.xxl.verticalSpace,
                        AppReactiveTextField.password(
                          formControlName: AuthForms.newPasswordField,
                          title: AppStrings.newPassword,
                          hintText: AppStrings.newPassword,
                        ),
                        AppSpacing.lg.verticalSpace,
                        AppReactiveTextField.password(
                          formControlName: AuthForms.confirmPasswordField,
                          title: AppStrings.confirmPassword,
                          hintText: AppStrings.confirmPassword,
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
                              isLoading: state.forceResetStatus.isLoading,
                              layout: const AppButtonLayout(height: 52),
                              onTapWhenInactive: () {
                                if (!passwordsMatch) {
                                  printY(
                                    '[ForcePasswordResetBody] submit blocked '
                                    'passwords do not match',
                                  );
                                  showErrorOverlay(
                                    context,
                                    AppStrings.passwordsDoNotMatch,
                                  );
                                }
                              },
                              onTap: () {
                                printC('[ForcePasswordResetBody] submit reset');
                                context.read<AuthBloc>().add(
                                  AuthEvent.forceResetPasswordRequested(
                                    newPassword ?? '',
                                  ),
                                );
                              },
                              child: AppButtonChild.label(
                                AppStrings.resetPassword,
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
