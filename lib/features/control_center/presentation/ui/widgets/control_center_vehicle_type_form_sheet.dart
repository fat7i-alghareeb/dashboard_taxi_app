import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/control_center/constants/control_center_forms.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';

/// Bottom sheet to create or edit a vehicle type. Edit mode locks the code
/// (the backend treats it as the immutable business key).
class ControlCenterVehicleTypeFormSheet extends StatefulWidget {
  const ControlCenterVehicleTypeFormSheet({super.key, this.initial});

  final DashboardVehicleTypeEntity? initial;

  @override
  State<ControlCenterVehicleTypeFormSheet> createState() =>
      _ControlCenterVehicleTypeFormSheetState();

  static Future<void> show(
    BuildContext context, {
    DashboardVehicleTypeEntity? initial,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<DashboardBloc>(),
        child: ControlCenterVehicleTypeFormSheet(initial: initial),
      ),
    );
  }
}

class _ControlCenterVehicleTypeFormSheetState
    extends State<ControlCenterVehicleTypeFormSheet> {
  late final FormGroup _form;

  bool get _isEditMode => widget.initial != null;

  @override
  void initState() {
    super.initState();
    final v = widget.initial;
    _form = ControlCenterForms.vehicleTypeForm(
      code: v?.code,
      name: v?.name,
      capacity: v?.capacity,
      ratePerKm: v?.ratePerKm.toDouble(),
      ratePerMin: v?.ratePerMin.toDouble(),
      minFare: v?.minFare.toDouble(),
      sortOrder: v?.sortOrder,
      isActive: v?.isActive,
    );
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _submit() {
    if (_form.invalid) {
      _form.markAllAsTouched();
      return;
    }

    final code = (_form.control(ControlCenterForms.codeField).value as String)
        .trim();
    final name = (_form.control(ControlCenterForms.nameField).value as String)
        .trim();
    final capacity = int.tryParse(
          (_form.control(ControlCenterForms.capacityField).value as String).trim(),
        ) ??
        4;
    final ratePerKm = double.tryParse(
          (_form.control(ControlCenterForms.ratePerKmField).value as String).trim(),
        ) ??
        0;
    final ratePerMin = double.tryParse(
          (_form.control(ControlCenterForms.ratePerMinField).value as String).trim(),
        ) ??
        0;
    final minFare = double.tryParse(
          (_form.control(ControlCenterForms.minFareField).value as String).trim(),
        ) ??
        0;
    final sortOrder = int.tryParse(
          (_form.control(ControlCenterForms.sortOrderField).value as String).trim(),
        ) ??
        0;
    final isActive = _form.control(ControlCenterForms.isActiveField).value
        as bool;

    final bloc = context.read<DashboardBloc>();

    if (_isEditMode) {
      bloc.add(
        DashboardEvent.vehicleTypeUpdateRequested(
          DashboardVehicleTypeEntity(
            id: widget.initial!.id,
            code: widget.initial!.code,
            name: name,
            capacity: capacity,
            ratePerKm: ratePerKm,
            ratePerMin: ratePerMin,
            minFare: minFare,
            sortOrder: sortOrder,
            isActive: isActive,
          ),
        ),
      );
    } else {
      bloc.add(
        DashboardEvent.vehicleTypeCreateRequested(
          code: code,
          name: name,
          capacity: capacity,
          ratePerKm: ratePerKm,
          ratePerMin: ratePerMin,
          minFare: minFare,
          sortOrder: sortOrder,
        ),
      );
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: REdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: ReactiveForm(
          formGroup: _form,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 48.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: context.onSurface.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                AppSpacing.md.verticalSpace,
                Text(
                  _isEditMode
                      ? AppStrings.settingsVehicleTypeEditTitle
                      : AppStrings.settingsVehicleTypeAddTitle,
                  style: AppTextStyles.s18w600.copyWith(color: context.onSurface),
                ),
                AppSpacing.lg.verticalSpace,
                AppReactiveTextField.text(
                  formControlName: ControlCenterForms.codeField,
                  title: AppStrings.settingsVehicleTypeCode,
                  enabled: !_isEditMode,
                ),
                AppSpacing.md.verticalSpace,
                AppReactiveTextField.text(
                  formControlName: ControlCenterForms.nameField,
                  title: AppStrings.settingsVehicleTypeName,
                ),
                AppSpacing.md.verticalSpace,
                AppReactiveTextField.integer(
                  formControlName: ControlCenterForms.capacityField,
                  title: AppStrings.settingsVehicleTypeCapacity,
                ),
                AppSpacing.md.verticalSpace,
                AppReactiveTextField.decimal(
                  formControlName: ControlCenterForms.ratePerKmField,
                  title: AppStrings.settingsVehicleTypeRatePerKm,
                ),
                AppSpacing.md.verticalSpace,
                AppReactiveTextField.decimal(
                  formControlName: ControlCenterForms.ratePerMinField,
                  title: AppStrings.settingsVehicleTypeRatePerMin,
                ),
                AppSpacing.md.verticalSpace,
                AppReactiveTextField.decimal(
                  formControlName: ControlCenterForms.minFareField,
                  title: AppStrings.settingsVehicleTypeMinFare,
                ),
                AppSpacing.md.verticalSpace,
                AppReactiveTextField.integer(
                  formControlName: ControlCenterForms.sortOrderField,
                  title: AppStrings.settingsVehicleTypeSortOrder,
                ),
                AppSpacing.md.verticalSpace,
                const _ActiveToggle(
                  formControlName: ControlCenterForms.isActiveField,
                ),
                AppSpacing.lg.verticalSpace,
                AppButton.primary(
                  layout: const AppButtonLayout(height: 52),
                  onTap: _submit,
                  child: AppButtonChild.label(
                    AppStrings.settingsSaveLabel,
                    textStyle: AppTextStyles.s14w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActiveToggle extends StatelessWidget {
  const _ActiveToggle({required this.formControlName});

  final String formControlName;

  @override
  Widget build(BuildContext context) {
    return AppReactiveSwitchTile(
      formControlName: formControlName,
      title: AppStrings.settingsVehicleTypeActive,
    );
  }
}
