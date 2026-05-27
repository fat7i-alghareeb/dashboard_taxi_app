import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:pinput/pinput.dart';

import 'package:dashboardtaxi/features/auth/constants/forms/auth_forms.dart';
import 'package:dashboardtaxi/features/auth/presentation/states/auth_bloc.dart';

class LoginOtpSection extends StatelessWidget {
  const LoginOtpSection({super.key, required this.form});

  final FormGroup form;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48.w,
      height: 56.h,
      textStyle: AppTextStyles.s20w700.copyWith(color: context.onSurface),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.12)),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Column(
                children: [
                  Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: context.primary, width: 1.5),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: context.error),
                      ),
                    ),
                    forceErrorState: state.otpStatus.isFailed,
                    onCompleted: (pin) {
                      form.control(AuthForms.otpField).value = pin;
                      printB(
                        '[LoginOtpSection] otp completed length=${pin.length}',
                      );
                      context.read<AuthBloc>().add(
                        AuthEvent.verifyOtpRequested(pin),
                      );
                    },
                    onChanged: (pin) {
                      form.control(AuthForms.otpField).value = pin;
                    },
                  ),
                  if (state.otpStatus.isFailed) ...[
                    AppSpacing.md.verticalSpace,
                    Text(
                      AppStrings.invalidOtp,
                      style: AppTextStyles.s12w500.copyWith(
                        color: context.error,
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
        AppSpacing.xl.verticalSpace,
        ReactiveFormConsumer(
          builder: (context, form, child) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return AppButton.primary(
                  child: AppButtonChild.label(AppStrings.verifyOtp),
                  isActive: form.control(AuthForms.otpField).valid,
                  isLoading: state.otpStatus.isLoading,
                  layout: const AppButtonLayout(height: 52),
                  onTap: () {
                    final otp =
                        form.control(AuthForms.otpField).value as String;
                    printB(
                      '[LoginOtpSection] verify otp tapped length=${otp.length}',
                    );
                    context.read<AuthBloc>().add(
                      AuthEvent.verifyOtpRequested(otp),
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
