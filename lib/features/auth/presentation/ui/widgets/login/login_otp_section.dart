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
      width: 56.w,
      height: 56.h,
      textStyle: AppTextStyles.s24w700.copyWith(color: context.onSurface),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        border: Border.all(color: context.grey),
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
                        border: Border.all(color: context.primary),
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
                      context.read<AuthBloc>().add(
                        AuthEvent.verifyOtpRequested(pin),
                      );
                    },
                    onChanged: (pin) {
                      form.control(AuthForms.otpField).value = pin;
                    },
                  ),
                  if (state.otpStatus.isFailed) ...[
                    AppSpacing.sm.verticalSpace,
                    Text(
                      AppStrings.invalidOtp,
                      style: AppTextStyles.s14w400.copyWith(
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
                return AppButton.primaryGradient(
                  child: AppButtonChild.label(AppStrings.verifyOtp),
                  isActive: form.control(AuthForms.otpField).valid,
                  isLoading: state.otpStatus.isLoading,
                  onTap: () {
                    final otp =
                        form.control(AuthForms.otpField).value as String;
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
