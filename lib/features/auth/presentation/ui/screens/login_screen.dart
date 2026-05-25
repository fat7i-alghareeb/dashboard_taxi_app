import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';

import 'package:dashboardtaxi/features/auth/constants/forms/auth_forms.dart';
import 'package:dashboardtaxi/features/auth/presentation/states/auth_bloc.dart';
import 'package:dashboardtaxi/features/auth/presentation/ui/widgets/login/login_otp_section.dart';
import 'package:dashboardtaxi/features/auth/presentation/ui/widgets/login/login_phone_section.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String pagePath = '/login_screen';
  static const String pageName = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(const AuthEvent.started()),
      child: const _LoginScreenBody(),
    );
  }
}

class _LoginScreenBody extends StatefulWidget {
  const _LoginScreenBody();

  @override
  State<_LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<_LoginScreenBody> {
  final _form = AuthForms.loginFormGroup();

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.isOtpSent != current.isOtpSent ||
          (!previous.phoneStatus.isFailed && current.phoneStatus.isFailed),
      listener: (context, state) {
        if (!state.isOtpSent) {
          _form.control(AuthForms.otpField).reset();
        }

        if (state.phoneStatus.isFailed) {
          showErrorOverlay(
            context,
            state.phoneStatus.errorMessage ?? AppStrings.somethingWentWrong,
          );
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: !state.isOtpSent,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            if (state.isOtpSent) {
              context.read<AuthBloc>().add(const AuthEvent.resetRequested());
            }
          },
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
                          if (state.isOtpSent)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(
                                    const AuthEvent.resetRequested(),
                                  );
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.chevronLeft,
                                  size: 20.r,
                                  color: context.onSurface,
                                ),
                              ),
                            ).animate().fadeIn().slideX(begin: -0.2),

                          (state.isOtpSent ? AppSpacing.xl : AppSpacing.xxl * 2)
                              .verticalSpace,

                          // Logo
                          Center(
                                child: Assets.images.oranjeLogo.image(
                                  height: 140.h,
                                  fit: BoxFit.contain,
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 600.ms)
                              .scale(
                                begin: const Offset(0.8, 0.8),
                                curve: Curves.easeOutBack,
                              ),

                          AppSpacing.xxl.verticalSpace,

                          // Welcome Text
                          Column(
                            children: [
                              Text(
                                state.isOtpSent
                                    ? AppStrings.otp
                                    : AppStrings.login,
                                style: AppTextStyles.s40w700.copyWith(
                                  color: context.onSurface,
                                  height: 1.1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              AppSpacing.sm.verticalSpace,
                              Text(
                                state.isOtpSent
                                    ? AppStrings.enterOtp
                                    : AppStrings.enterPhone,
                                style: AppTextStyles.s16w400.copyWith(
                                  color: context.onSurfaceVariant,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),

                          (AppSpacing.xxl * 1.5).verticalSpace,

                          // Input Section
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
                                      alpha: 0.1,
                                    ),
                                  ),
                                ),
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 400),
                                  transitionBuilder: (child, animation) =>
                                      FadeTransition(
                                        opacity: animation,
                                        child: SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0, 0.1),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        ),
                                      ),
                                  child: !state.isOtpSent
                                      ? LoginPhoneSection(
                                          key: const ValueKey('phone'),
                                          form: _form,
                                        )
                                      : LoginOtpSection(
                                          key: const ValueKey('otp'),
                                          form: _form,
                                        ),
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
        );
      },
    );
  }
}
