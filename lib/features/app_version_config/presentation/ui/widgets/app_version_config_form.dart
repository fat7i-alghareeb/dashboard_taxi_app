import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/app_version_config/domain/entities/app_version_config_entity.dart';
import 'package:dashboardtaxi/features/app_version_config/domain/entities/app_version_platform_entity.dart';
import 'package:dashboardtaxi/features/app_version_config/presentation/states/app_version_config_bloc.dart';
import 'package:dashboardtaxi/features/app_version_config/presentation/ui/widgets/app_version_platform_fields.dart';

class AppVersionConfigForm extends StatefulWidget {
  const AppVersionConfigForm({
    super.key,
    required this.config,
    required this.isSaving,
  });

  final AppVersionConfigEntity config;
  final bool isSaving;

  @override
  State<AppVersionConfigForm> createState() => _AppVersionConfigFormState();
}

class _AppVersionConfigFormState extends State<AppVersionConfigForm> {
  static const String _fieldEnabled = 'enabled';
  static const String _fieldAndroidLatest = 'androidLatest';
  static const String _fieldAndroidMinimum = 'androidMinimum';
  static const String _fieldAndroidStoreUrl = 'androidStoreUrl';
  static const String _fieldIosLatest = 'iosLatest';
  static const String _fieldIosMinimum = 'iosMinimum';
  static const String _fieldIosStoreUrl = 'iosStoreUrl';

  /// Mirrors the server rule so the admin sees the problem before a round-trip.
  /// Blank is allowed everywhere: it clears the key and leaves that platform
  /// ungated.
  static final RegExp _versionPattern = RegExp(r'^\d{1,4}(\.\d{1,4}){0,3}$');
  static final RegExp _storeUrlPattern = RegExp(r'^https://\S+$');

  late final FormGroup _form;
  late Map<String, String> _initialValues;

  @override
  void initState() {
    super.initState();
    final android = widget.config.android;
    final ios = widget.config.ios;

    _form = FormGroup({
      _fieldEnabled: FormControl<bool>(value: widget.config.enabled),
      _fieldAndroidLatest: FormControl<String>(
        value: android.latestVersion,
        validators: [Validators.pattern(_versionPattern)],
      ),
      _fieldAndroidMinimum: FormControl<String>(
        value: android.minimumRequiredVersion,
        validators: [Validators.pattern(_versionPattern)],
      ),
      _fieldAndroidStoreUrl: FormControl<String>(
        value: android.storeUrl,
        validators: [Validators.pattern(_storeUrlPattern)],
      ),
      _fieldIosLatest: FormControl<String>(
        value: ios.latestVersion,
        validators: [Validators.pattern(_versionPattern)],
      ),
      _fieldIosMinimum: FormControl<String>(
        value: ios.minimumRequiredVersion,
        validators: [Validators.pattern(_versionPattern)],
      ),
      _fieldIosStoreUrl: FormControl<String>(
        value: ios.storeUrl,
        validators: [Validators.pattern(_storeUrlPattern)],
      ),
    });

    _initialValues = _snapshot();
  }

  /// `toString()` rather than a `String?` cast: the group holds a
  /// `FormControl<bool>` alongside the string controls, and casting every value
  /// to `String?` would throw at runtime.
  Map<String, String> _snapshot() => {
    for (final key in _form.controls.keys)
      key: (_form.control(key).value?.toString() ?? '').trim(),
  };

  bool get _hasChanges {
    final current = _snapshot();
    for (final entry in _initialValues.entries) {
      if (current[entry.key] != entry.value) return true;
    }
    return false;
  }

  String _text(String name) =>
      ((_form.control(name).value as String?) ?? '').trim();

  bool get _enabled => (_form.control(_fieldEnabled).value as bool?) ?? false;

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_form.invalid) {
      _form.markAllAsTouched();
      return;
    }

    context.read<AppVersionConfigBloc>().add(
      AppVersionConfigUpdateRequested(
        config: AppVersionConfigEntity(
          enabled: _enabled,
          android: AppVersionPlatformEntity(
            latestVersion: _text(_fieldAndroidLatest),
            minimumRequiredVersion: _text(_fieldAndroidMinimum),
            storeUrl: _text(_fieldAndroidStoreUrl),
          ),
          ios: AppVersionPlatformEntity(
            latestVersion: _text(_fieldIosLatest),
            minimumRequiredVersion: _text(_fieldIosMinimum),
            storeUrl: _text(_fieldIosStoreUrl),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppVersionConfigBloc, AppVersionConfigState>(
      listenWhen: (a, b) => a.updateStatus != b.updateStatus,
      listener: (context, state) {
        if (state.updateStatus.isSuccess) {
          setState(() => _initialValues = _snapshot());
        }
      },
      child: ReactiveForm(
        formGroup: _form,
        child: SingleChildScrollView(
          padding: REdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppStrings.appVersionConfigDescription,
                style: AppTextStyles.s12w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.6),
                ),
              ),
              AppSpacing.xl.verticalSpace,
              AppReactiveSwitchTile(
                formControlName: _fieldEnabled,
                title: AppStrings.appVersionConfigEnabledTitle,
                subtitle: AppStrings.appVersionConfigEnabledSubtitle,
                defaultValue: false,
              ),
              AppSpacing.xl.verticalSpace,
              AppSectionShell(
                icon: FontAwesomeIcons.android,
                title: AppStrings.appVersionConfigAndroidTitle,
                subtitle: AppStrings.appVersionConfigAndroidSubtitle,
                child: const AppVersionPlatformFields(
                  latestControlName: _fieldAndroidLatest,
                  minimumControlName: _fieldAndroidMinimum,
                  storeUrlControlName: _fieldAndroidStoreUrl,
                ),
              ),
              AppSpacing.xl.verticalSpace,
              AppSectionShell(
                icon: FontAwesomeIcons.apple,
                title: AppStrings.appVersionConfigIosTitle,
                subtitle: AppStrings.appVersionConfigIosSubtitle,
                child: const AppVersionPlatformFields(
                  latestControlName: _fieldIosLatest,
                  minimumControlName: _fieldIosMinimum,
                  storeUrlControlName: _fieldIosStoreUrl,
                ),
              ),
              AppSpacing.xl.verticalSpace,
              ReactiveFormConsumer(
                builder: (context, form, _) {
                  if (!_hasChanges) return const SizedBox.shrink();
                  return AppButton.primary(
                    isLoading: widget.isSaving,
                    layout: const AppButtonLayout(height: 52),
                    onTap: () => _submit(context),
                    child: AppButtonChild.label(
                      AppStrings.appVersionConfigSaveButton,
                      textStyle: AppTextStyles.s14w600,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
