import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/auth/constants/forms/auth_forms.dart';
import 'package:dashboardtaxi/features/auth/presentation/states/auth_bloc.dart';
import 'package:dashboardtaxi/features/root/presentation/ui/screens/root_screen.dart';

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
            showSuccessOverlay(context, AppStrings.passwordResetSuccess);
            context.go(RootScreen.pagePath);
          },
          failure: (message) {
            showErrorOverlay(context, message);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return ReactiveForm(
          formGroup: _form,
          child: AppScaffold.body(
            scaffoldConfig: AppScaffoldConfig(
              backgroundColor: context.surface,
              safeArea: [],
            ),
            child: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: REdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.shieldHalved,
                            size: 48.r,
                            color: context.primary,
                          ).animate().fadeIn().scale(
                            begin: const Offset(0.9, 0.9),
                          ),
                          AppSpacing.xl.verticalSpace,
                          Text(
                            AppStrings.forcePasswordReset,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.s24w700.copyWith(
                              color: context.onSurface,
                            ),
                          ).animate().fadeIn(delay: AppDurations.fast),
                          AppSpacing.sm.verticalSpace,
                          Text(
                            AppStrings.forcePasswordResetSubtitle,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.s14w400.copyWith(
                              color: context.onSurface.withValues(alpha: 0.64),
                            ),
                          ).animate().fadeIn(delay: AppDurations.normal),
                          AppSpacing.xxl.verticalSpace,
                          DecoratedBox(
                                decoration: BoxDecoration(
                                  color: context.surface,
                                  borderRadius: BorderRadius.circular(
                                    AppRadii.xl.r,
                                  ),
                                  border: Border.all(
                                    color: context.primary.withValues(
                                      alpha: 0.10,
                                    ),
                                  ),
                                  boxShadow: context.shadows.primary,
                                ),
                                child: Padding(
                                  padding: REdgeInsets.all(AppSpacing.xl),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      AppReactiveTextField.password(
                                        formControlName:
                                            AuthForms.newPasswordField,
                                        title: AppStrings.newPassword,
                                        hintText: AppStrings.newPassword,
                                      ),
                                      AppSpacing.lg.verticalSpace,
                                      AppReactiveTextField.password(
                                        formControlName:
                                            AuthForms.confirmPasswordField,
                                        title: AppStrings.confirmPassword,
                                        hintText: AppStrings.confirmPassword,
                                      ),
                                      AppSpacing.xl.verticalSpace,
                                      ReactiveFormConsumer(
                                        builder: (context, form, child) {
                                          final newPassword =
                                              form
                                                      .control(
                                                        AuthForms
                                                            .newPasswordField,
                                                      )
                                                      .value
                                                  as String?;
                                          final confirmPassword =
                                              form
                                                      .control(
                                                        AuthForms
                                                            .confirmPasswordField,
                                                      )
                                                      .value
                                                  as String?;
                                          final passwordsMatch =
                                              newPassword == confirmPassword;
                                          final canSubmit =
                                              form.valid && passwordsMatch;

                                          return AppButton.primaryGradient(
                                            isActive: canSubmit,
                                            isLoading: state
                                                .forceResetStatus
                                                .isLoading,
                                            onTapWhenInactive: () {
                                              if (!passwordsMatch) {
                                                showErrorOverlay(
                                                  context,
                                                  AppStrings
                                                      .passwordsDoNotMatch,
                                                );
                                              }
                                            },
                                            onTap: () {
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
                                    ],
                                  ),
                                ),
                              )
                              .animate()
                              .fadeIn(delay: AppDurations.normal)
                              .slideY(begin: 0.08),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
