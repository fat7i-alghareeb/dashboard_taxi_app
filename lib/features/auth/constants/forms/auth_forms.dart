import 'package:reactive_forms/reactive_forms.dart';

abstract class AuthForms {
  static const String phoneField = 'phone';
  static const String otpField = 'otp';
  static const String newPasswordField = 'newPassword';
  static const String confirmPasswordField = 'confirmPassword';

  static FormGroup loginFormGroup() => FormGroup({
    phoneField: FormControl<String>(validators: [Validators.required]),
    otpField: FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(6),
        Validators.maxLength(6),
      ],
    ),
  });

  static FormGroup forceResetFormGroup() => FormGroup({
    newPasswordField: FormControl<String>(
      validators: [Validators.required, Validators.minLength(8)],
    ),
    confirmPasswordField: FormControl<String>(
      validators: [Validators.required, Validators.minLength(8)],
    ),
  });
}
