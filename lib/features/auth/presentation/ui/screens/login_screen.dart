import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/auth/constants/forms/auth_forms.dart';
import 'package:dashboardtaxi/features/auth/presentation/states/auth_bloc.dart';
import 'package:dashboardtaxi/features/auth/presentation/ui/widgets/auth_header_widget.dart';
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
          printC('[LoginScreen] OTP flow reset; clearing OTP field');
          _form.control(AuthForms.otpField).reset();
        }
        if (state.phoneStatus.isFailed) {
          printY(
            '[LoginScreen] phone status failed '
            'message=${state.phoneStatus.errorMessage}',
          );
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
              printC('[LoginScreen] back intercepted; resetting OTP flow');
              context.read<AuthBloc>().add(const AuthEvent.resetRequested());
            }
          },
          child: ReactiveForm(
            formGroup: _form,
            child: AppScaffold.body(
              scaffoldConfig: AppScaffoldConfig(
                backgroundColor: context.surface,
              ),
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
                            title: state.isOtpSent
                                ? AppStrings.authOtpTitle
                                : AppStrings.authDriverWelcomeTitle,
                            subtitle: state.isOtpSent
                                ? AppStrings.authOtpSubtitle
                                : AppStrings.authDriverWelcomeSubtitle,
                            onBack: state.isOtpSent
                                ? () {
                                    context.read<AuthBloc>().add(
                                      const AuthEvent.resetRequested(),
                                    );
                                  }
                                : null,
                          ),
                          AppSpacing.xxl.verticalSpace,
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 320),
                            transitionBuilder: (child, animation) =>
                                FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, 0.06),
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
                          const Spacer(),
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
