import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/auth/constants/forms/auth_forms.dart';
import 'package:dashboardtaxi/features/auth/domain/facade/auth_facade.dart';
import 'package:dashboardtaxi/features/auth/presentation/states/admin_auth_bloc.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  static const String pagePath = '/admin_login';
  static const String pageName = 'AdminLoginScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminAuthBloc(getIt<AuthFacade>()),
      child: const _AdminLoginBody(),
    );
  }
}

class _AdminLoginBody extends StatefulWidget {
  const _AdminLoginBody();

  @override
  State<_AdminLoginBody> createState() => _AdminLoginBodyState();
}

class _AdminLoginBodyState extends State<_AdminLoginBody> {
  final _form = AuthForms.adminLoginFormGroup();

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_form.invalid) {
      printY('[AdminLoginScreen] submit blocked because form is invalid');
      _form.markAllAsTouched();
      return;
    }
    final userName = (_form.control(AuthForms.userNameField).value as String)
        .trim();
    final password = (_form.control(AuthForms.passwordField).value as String)
        .trim();
    printC('[AdminLoginScreen] submit userName="$userName"');
    context.read<AdminAuthBloc>().add(
      AdminLoginRequested(userName: userName, password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminAuthBloc, AdminAuthState>(
      listenWhen: (prev, curr) => prev.loginStatus != curr.loginStatus,
      listener: (context, state) {
        if (state.loginStatus.isFailed) {
          printY(
            '[AdminLoginScreen] login failed overlay '
            'message=${state.loginStatus.errorMessage}',
          );
          showErrorOverlay(
            context,
            state.loginStatus.errorMessage ?? AppStrings.authLoginFailed,
          );
        } else if (state.loginStatus.isSuccess) {
          printG('[AdminLoginScreen] login success observed');
        }
      },
      child: PopScope(
        canPop: false,
        child: ReactiveForm(
          formGroup: _form,
          child: AppScaffold.body(
            scaffoldConfig: AppScaffoldConfig(
              backgroundColor: context.surface,
              safeArea: [],
            ),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: REdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.xxl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          child: Assets.images.oranjeLogo
                              .image(height: 140.h, fit: BoxFit.contain)
                              .animate()
                              .fadeIn(duration: 600.ms)
                              .scale(
                                begin: const Offset(0.8, 0.8),
                                curve: Curves.easeOutBack,
                              ),
                        ),
                        AppSpacing.xxl.verticalSpace,
                        Column(
                          children: [
                            Text(
                              AppStrings.authAdminTitle,
                              style: AppTextStyles.s40w700.copyWith(
                                color: context.onSurface,
                                height: 1.1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            AppSpacing.sm.verticalSpace,
                            Text(
                              AppStrings.authAdminSubtitle,
                              style: AppTextStyles.s16w400.copyWith(
                                color: context.onSurfaceVariant,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
                        (AppSpacing.xxl * 1.5).verticalSpace,
                        Container(
                              padding: REdgeInsets.all(AppSpacing.xl),
                              decoration: BoxDecoration(
                                color: context.surface,
                                borderRadius: BorderRadius.circular(
                                  AppRadii.xl.r,
                                ),
                                boxShadow: context.shadows.primary,
                                border: Border.all(
                                  color: context.primary.withValues(
                                    alpha: 0.10,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  AppReactiveTextField.text(
                                    formControlName: AuthForms.userNameField,
                                    title: AppStrings.authUserName,
                                    hintText: AppStrings.authUserNameHint,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  AppSpacing.lg.verticalSpace,
                                  AppReactiveTextField.password(
                                    formControlName: AuthForms.passwordField,
                                    title: AppStrings.authPassword,
                                    hintText: AppStrings.authPasswordHint,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (_, _) => _submit(context),
                                  ),
                                  AppSpacing.xl.verticalSpace,
                                  BlocBuilder<AdminAuthBloc, AdminAuthState>(
                                    builder: (context, state) {
                                      return ReactiveFormConsumer(
                                        builder: (context, form, child) {
                                          return AppButton.primary(
                                            isActive: form.valid,
                                            isLoading:
                                                state.loginStatus.isLoading,
                                            layout: const AppButtonLayout(
                                              height: 52,
                                            ),
                                            onTap: () => _submit(context),
                                            child: AppButtonChild.label(
                                              AppStrings.authLoginButton,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                            .animate()
                            .fadeIn(delay: 400.ms)
                            .scale(
                              begin: const Offset(0.95, 0.95),
                              curve: Curves.easeOut,
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
