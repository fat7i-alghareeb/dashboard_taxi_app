import 'package:reactive_forms/reactive_forms.dart';

abstract class AdminManagementForms {
  static const String userNameField = 'userName';
  static const String passwordField = 'password';
  static const String passwordConfirmationField = 'passwordConfirmation';
  static const String nameField = 'name';
  static const String emailField = 'email';
  static const String phone1Field = 'phone1';
  static const String phone2Field = 'phone2';

  static FormGroup registerAdminFormGroup() => FormGroup(
    {
      userNameField: FormControl<String>(validators: [Validators.required]),
      passwordField: FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)],
      ),
      passwordConfirmationField: FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)],
      ),
      nameField: FormControl<String>(validators: [Validators.required]),
      emailField: FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      phone1Field: FormControl<String>(),
      phone2Field: FormControl<String>(),
    },
    validators: [
      Validators.mustMatch(passwordField, passwordConfirmationField),
    ],
  );
}
