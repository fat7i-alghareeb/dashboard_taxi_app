import 'package:reactive_forms/reactive_forms.dart';

abstract class KycForms {
  static const String licenseField = 'driversLicense';
  static const String idField = 'nationalId';
  static const String registrationField = 'vehicleRegistration';
  static const String insuranceField = 'insurance';

  static FormGroup formGroup() => FormGroup({
        licenseField: FormControl<String>(validators: [Validators.required]),
        idField: FormControl<String>(validators: [Validators.required]),
        registrationField: FormControl<String>(validators: [Validators.required]),
        insuranceField: FormControl<String>(validators: [Validators.required]),
      });
}
