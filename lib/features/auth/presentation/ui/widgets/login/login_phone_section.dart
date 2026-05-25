import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/auth/constants/forms/auth_forms.dart';
import 'package:dashboardtaxi/features/auth/presentation/states/auth_bloc.dart';

class LoginPhoneSection extends StatelessWidget {
  const LoginPhoneSection({super.key, required this.form});

  final FormGroup form;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppReactiveTextField.phone(
          formControlName: AuthForms.phoneField,
          title: AppStrings.phoneNumber,
          hintText: AppStrings.enterPhone,
          phoneDefaultIsoCode: 'NL',
        ),
        AppSpacing.xl.verticalSpace,
        ReactiveFormConsumer(
          builder: (context, form, child) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return AppButton.primaryGradient(
                  child: AppButtonChild.label(AppStrings.sendOtp),
                  isActive: form.control(AuthForms.phoneField).valid,
                  isLoading: state.phoneStatus.isLoading,
                  onTap: () {
                    final phone =
                        form.control(AuthForms.phoneField).value as String;
                    context.read<AuthBloc>().add(
                      AuthEvent.sendOtpRequested(phone),
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
