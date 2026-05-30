import 'package:reactive_forms/reactive_forms.dart';

/// Reactive form definition for the vehicle type editor used inside the
/// Control Center fleet section.
abstract class ControlCenterForms {
  static const String codeField = 'code';
  static const String nameField = 'name';
  static const String capacityField = 'capacity';
  static const String ratePerKmField = 'ratePerKm';
  static const String ratePerMinField = 'ratePerMin';
  static const String minFareField = 'minFare';
  static const String sortOrderField = 'sortOrder';
  static const String isActiveField = 'isActive';

  static FormGroup vehicleTypeForm({
    String? code,
    String? name,
    int? capacity,
    double? ratePerKm,
    double? ratePerMin,
    double? minFare,
    int? sortOrder,
    bool? isActive,
  }) => FormGroup({
    codeField: FormControl<String>(
      value: code,
      validators: [Validators.required],
    ),
    nameField: FormControl<String>(
      value: name,
      validators: [Validators.required],
    ),
    capacityField: FormControl<String>(
      value: capacity?.toString() ?? '4',
      validators: [Validators.required],
    ),
    ratePerKmField: FormControl<String>(
      value: ratePerKm?.toString() ?? '',
      validators: [Validators.required],
    ),
    ratePerMinField: FormControl<String>(
      value: ratePerMin?.toString() ?? '',
      validators: [Validators.required],
    ),
    minFareField: FormControl<String>(
      value: minFare?.toString() ?? '',
      validators: [Validators.required],
    ),
    sortOrderField: FormControl<String>(
      value: sortOrder?.toString() ?? '0',
      validators: [Validators.required],
    ),
    isActiveField: FormControl<bool>(
      value: isActive ?? true,
      validators: [Validators.required],
    ),
  });
}
