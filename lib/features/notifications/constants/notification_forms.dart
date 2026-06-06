import 'package:reactive_forms/reactive_forms.dart';

abstract class NotificationForms {
  static const String titleField = 'title';
  static const String bodyField = 'body';

  static FormGroup broadcastFormGroup() => FormGroup({
    titleField: FormControl<String>(
      validators: [Validators.required, Validators.maxLength(120)],
    ),
    bodyField: FormControl<String>(
      validators: [Validators.required, Validators.maxLength(500)],
    ),
  });
}
