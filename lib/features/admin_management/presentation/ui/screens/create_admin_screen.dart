import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/admin_management/constants/admin_management_forms.dart';
import 'package:dashboardtaxi/features/admin_management/data/params/register_admin_params.dart';
import 'package:dashboardtaxi/features/admin_management/domain/facade/admin_management_facade.dart';
import 'package:dashboardtaxi/features/admin_management/presentation/states/create_admin_bloc.dart';

class CreateAdminScreen extends StatelessWidget {
  const CreateAdminScreen({super.key});

  static const String pagePath = '/create-admin';
  static const String pageName = 'CreateAdminScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateAdminBloc(getIt<AdminManagementFacade>()),
      child: const _CreateAdminBody(),
    );
  }
}

class _CreateAdminBody extends StatefulWidget {
  const _CreateAdminBody();

  @override
  State<_CreateAdminBody> createState() => _CreateAdminBodyState();
}

class _CreateAdminBodyState extends State<_CreateAdminBody> {
  final _form = AdminManagementForms.registerAdminFormGroup();

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

    String? optional(String field) {
      final value = (_form.control(field).value as String?)?.trim();
      return (value == null || value.isEmpty) ? null : value;
    }

    final params = RegisterAdminParams(
      userName: (_form.control(AdminManagementForms.userNameField).value
              as String)
          .trim(),
      password: (_form.control(AdminManagementForms.passwordField).value
              as String)
          .trim(),
      name: (_form.control(AdminManagementForms.nameField).value as String)
          .trim(),
      email: (_form.control(AdminManagementForms.emailField).value as String)
          .trim(),
      phone1: optional(AdminManagementForms.phone1Field),
      phone2: optional(AdminManagementForms.phone2Field),
    );

    context.read<CreateAdminBloc>().add(CreateAdminSubmitted(params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateAdminBloc, CreateAdminState>(
      listenWhen: (prev, curr) => prev.submitStatus != curr.submitStatus,
      listener: (context, state) {
        if (state.submitStatus.isSuccess) {
          showSuccessOverlay(context, AppStrings.createAdminSuccess);
          context.pop();
        } else if (state.submitStatus.isFailed) {
          showErrorOverlay(
            context,
            state.submitStatus.errorMessage ?? AppStrings.createAdminFailed,
          );
        }
      },
      child: ReactiveForm(
        formGroup: _form,
        child: AppScaffold.appBar(
          appBarConfig: AppScaffoldAppBarConfig(
            title: AppStrings.createAdminTitle,
            subtitle: AppStrings.createAdminSubtitle,
          ),
          child: SingleChildScrollView(
            padding: REdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppReactiveTextField.text(
                  formControlName: AdminManagementForms.nameField,
                  title: AppStrings.profileFieldName,
                  textInputAction: TextInputAction.next,
                ),
                AppSpacing.lg.verticalSpace,
                AppReactiveTextField.text(
                  formControlName: AdminManagementForms.userNameField,
                  title: AppStrings.authUserName,
                  hintText: AppStrings.authUserNameHint,
                  textInputAction: TextInputAction.next,
                ),
                AppSpacing.lg.verticalSpace,
                AppReactiveTextField.email(
                  formControlName: AdminManagementForms.emailField,
                  title: AppStrings.profileFieldEmail,
                  textInputAction: TextInputAction.next,
                ),
                AppSpacing.lg.verticalSpace,
                AppReactiveTextField.password(
                  formControlName: AdminManagementForms.passwordField,
                  title: AppStrings.authPassword,
                  hintText: AppStrings.authPasswordHint,
                  textInputAction: TextInputAction.next,
                ),
                AppSpacing.lg.verticalSpace,
                AppReactiveTextField.phone(
                  formControlName: AdminManagementForms.phone1Field,
                  title: AppStrings.profileFieldPhone,
                  textInputAction: TextInputAction.next,
                ),
                AppSpacing.lg.verticalSpace,
                AppReactiveTextField.phone(
                  formControlName: AdminManagementForms.phone2Field,
                  title: AppStrings.profileFieldPhone2,
                  textInputAction: TextInputAction.done,
                ),
                AppSpacing.xl.verticalSpace,
                BlocBuilder<CreateAdminBloc, CreateAdminState>(
                  builder: (context, state) {
                    return ReactiveFormConsumer(
                      builder: (context, form, child) {
                        return AppButton.primary(
                          isActive: form.valid,
                          isLoading: state.submitStatus.isLoading,
                          layout: const AppButtonLayout(height: 52),
                          onTap: () => _submit(context),
                          child: AppButtonChild.label(
                            AppStrings.createAdminSubmit,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
