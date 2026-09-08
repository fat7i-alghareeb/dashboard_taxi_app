import 'package:dashboardtaxi/common/imports/imports.dart';

/// The three version-gate fields for one platform.
///
/// Android and iOS share this widget; only the control names differ.
class AppVersionPlatformFields extends StatelessWidget {
  const AppVersionPlatformFields({
    super.key,
    required this.latestControlName,
    required this.minimumControlName,
    required this.storeUrlControlName,
  });

  final String latestControlName;
  final String minimumControlName;
  final String storeUrlControlName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppReactiveTextField.text(
          formControlName: latestControlName,
          title: AppStrings.appVersionConfigFieldLatestVersion,
          hintText: '1.2.3',
          textInputAction: TextInputAction.next,
          validation: AppTextFieldValidation(
            messages: {
              ValidationMessage.pattern: (_) =>
                  AppStrings.appVersionConfigVersionInvalid,
            },
          ),
        ),
        AppSpacing.md.verticalSpace,
        AppReactiveTextField.text(
          formControlName: minimumControlName,
          title: AppStrings.appVersionConfigFieldMinimumVersion,
          hintText: '1.0.0',
          textInputAction: TextInputAction.next,
          validation: AppTextFieldValidation(
            messages: {
              ValidationMessage.pattern: (_) =>
                  AppStrings.appVersionConfigVersionInvalid,
            },
          ),
        ),
        AppSpacing.md.verticalSpace,
        AppReactiveTextField.text(
          formControlName: storeUrlControlName,
          title: AppStrings.appVersionConfigFieldStoreUrl,
          hintText: 'https://',
          textInputAction: TextInputAction.next,
          validation: AppTextFieldValidation(
            messages: {
              ValidationMessage.pattern: (_) =>
                  AppStrings.appVersionConfigStoreUrlInvalid,
            },
          ),
        ),
      ],
    );
  }
}
