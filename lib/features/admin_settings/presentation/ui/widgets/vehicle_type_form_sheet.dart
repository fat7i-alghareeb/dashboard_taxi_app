import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';

/// Modal bottom sheet that lets the admin create a new vehicle type or
/// edit an existing one. Form fields cover the editable surface the backend
/// PUT/POST endpoints expose.
class VehicleTypeFormSheet extends StatefulWidget {
  const VehicleTypeFormSheet({super.key, this.initial});

  /// When non-null the sheet runs in edit mode; otherwise it runs in create mode.
  final DashboardVehicleTypeEntity? initial;

  @override
  State<VehicleTypeFormSheet> createState() => _VehicleTypeFormSheetState();

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
        child: VehicleTypeFormSheet(initial: initial),
      ),
    );
  }
}

class _VehicleTypeFormSheetState extends State<VehicleTypeFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _code;
  late final TextEditingController _name;
  late final TextEditingController _capacity;
  late final TextEditingController _ratePerKm;
  late final TextEditingController _ratePerMin;
  late final TextEditingController _minFare;
  late final TextEditingController _sortOrder;
  late bool _isActive;

  bool get _isEditMode => widget.initial != null;

  @override
  void initState() {
    super.initState();
    final v = widget.initial;
    _code = TextEditingController(text: v?.code ?? '');
    _name = TextEditingController(text: v?.name ?? '');
    _capacity = TextEditingController(text: v?.capacity.toString() ?? '4');
    _ratePerKm = TextEditingController(text: v?.ratePerKm.toString() ?? '');
    _ratePerMin = TextEditingController(text: v?.ratePerMin.toString() ?? '');
    _minFare = TextEditingController(text: v?.minFare.toString() ?? '');
    _sortOrder = TextEditingController(text: v?.sortOrder.toString() ?? '0');
    _isActive = v?.isActive ?? true;
  }

  @override
  void dispose() {
    _code.dispose();
    _name.dispose();
    _capacity.dispose();
    _ratePerKm.dispose();
    _ratePerMin.dispose();
    _minFare.dispose();
    _sortOrder.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final capacity = int.tryParse(_capacity.text.trim()) ?? 0;
    final ratePerKm = num.tryParse(_ratePerKm.text.trim()) ?? 0;
    final ratePerMin = num.tryParse(_ratePerMin.text.trim()) ?? 0;
    final minFare = num.tryParse(_minFare.text.trim()) ?? 0;
    final sortOrder = int.tryParse(_sortOrder.text.trim()) ?? 0;

    final bloc = context.read<DashboardBloc>();

    if (_isEditMode) {
      bloc.add(
        DashboardEvent.vehicleTypeUpdateRequested(
          DashboardVehicleTypeEntity(
            id: widget.initial!.id,
            code: widget.initial!.code,
            name: _name.text.trim(),
            capacity: capacity,
            ratePerKm: ratePerKm,
            ratePerMin: ratePerMin,
            minFare: minFare,
            sortOrder: sortOrder,
            isActive: _isActive,
          ),
        ),
      );
    } else {
      bloc.add(
        DashboardEvent.vehicleTypeCreateRequested(
          code: _code.text.trim(),
          name: _name.text.trim(),
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
    final mediaPadding = MediaQuery.of(context).viewInsets;
    return Padding(
      padding: EdgeInsets.only(bottom: mediaPadding.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: REdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 56.w,
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
                  style: AppTextStyles.s18w600.copyWith(
                    color: context.onSurface,
                  ),
                ),
                AppSpacing.lg.verticalSpace,
                _Field(
                  controller: _code,
                  label: AppStrings.settingsVehicleTypeCode,
                  enabled: !_isEditMode,
                  textCapitalization: TextCapitalization.characters,
                ),
                AppSpacing.md.verticalSpace,
                _Field(
                  controller: _name,
                  label: AppStrings.settingsVehicleTypeName,
                ),
                AppSpacing.md.verticalSpace,
                _Field(
                  controller: _capacity,
                  label: AppStrings.settingsVehicleTypeCapacity,
                  keyboardType: TextInputType.number,
                ),
                AppSpacing.md.verticalSpace,
                _Field(
                  controller: _ratePerKm,
                  label: AppStrings.settingsVehicleTypeRatePerKm,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                AppSpacing.md.verticalSpace,
                _Field(
                  controller: _ratePerMin,
                  label: AppStrings.settingsVehicleTypeRatePerMin,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                AppSpacing.md.verticalSpace,
                _Field(
                  controller: _minFare,
                  label: AppStrings.settingsVehicleTypeMinFare,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                AppSpacing.md.verticalSpace,
                _Field(
                  controller: _sortOrder,
                  label: AppStrings.settingsVehicleTypeSortOrder,
                  keyboardType: TextInputType.number,
                ),
                AppSpacing.md.verticalSpace,
                _ActiveToggle(
                  value: _isActive,
                  onChanged: (v) => setState(() => _isActive = v),
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

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    this.keyboardType,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final bool enabled;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.s12w500.copyWith(
            color: context.onSurface.withValues(alpha: 0.7),
          ),
        ),
        6.verticalSpace,
        TextFormField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          validator: (value) {
            final raw = value?.trim() ?? '';
            if (raw.isEmpty) return AppStrings.validationRequired;
            return null;
          },
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.md.r),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActiveToggle extends StatelessWidget {
  const _ActiveToggle({required this.value, required this.onChanged});
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppStrings.settingsVehicleTypeActive,
              style: AppTextStyles.s14w500.copyWith(color: context.onSurface),
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

