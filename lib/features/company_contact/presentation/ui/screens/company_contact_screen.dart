import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/company_contact/domain/entities/company_contact_entity.dart';
import 'package:dashboardtaxi/features/company_contact/presentation/states/company_contact_bloc.dart';

/// Admin-only screen to edit the company contact details (email, phone,
/// website) printed in the invoice footer.
class CompanyContactScreen extends StatelessWidget {
  const CompanyContactScreen({super.key});

  static const String pagePath = '/company-info';
  static const String pageName = 'CompanyContactScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<CompanyContactBloc>()..add(CompanyContactLoadRequested()),
      child: const _CompanyContactBody(),
    );
  }
}

class _CompanyContactBody extends StatelessWidget {
  const _CompanyContactBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyContactBloc, CompanyContactState>(
      listenWhen: (a, b) => a.updateStatus != b.updateStatus,
      listener: (context, state) {
        if (state.updateStatus.isSuccess) {
          showSuccessOverlay(context, AppStrings.companyInfoSavedSuccess);
          context
              .read<CompanyContactBloc>()
              .add(CompanyContactUpdateAcknowledged());
        } else if (state.updateStatus.isFailed) {
          showErrorOverlay(
            context,
            state.updateStatus.errorMessage ?? AppStrings.somethingWentWrong,
          );
          context
              .read<CompanyContactBloc>()
              .add(CompanyContactUpdateAcknowledged());
        }
      },
      builder: (context, state) {
        return AppScaffold.appBar(
          appBarConfig: AppScaffoldAppBarConfig(
            title: AppStrings.companyInfoTitle,
            subtitle: AppStrings.companyInfoSubtitle,
          ),
          child: StatusBuilder<CompanyContactEntity>(
            state: state.loadStatus,
            errorMessage: AppStrings.companyInfoLoadFailed,
            onError: () => context
                .read<CompanyContactBloc>()
                .add(CompanyContactLoadRequested()),
            success: (contact) => _CompanyContactForm(
              contact: contact,
              isSaving: state.updateStatus.isLoading,
            ),
          ),
        );
      },
    );
  }
}

class _CompanyContactForm extends StatefulWidget {
  const _CompanyContactForm({required this.contact, required this.isSaving});

  final CompanyContactEntity contact;
  final bool isSaving;

  @override
  State<_CompanyContactForm> createState() => _CompanyContactFormState();
}

class _CompanyContactFormState extends State<_CompanyContactForm> {
  static const _fieldEmail = 'email';
  static const _fieldPhone = 'phone';
  static const _fieldWebsite = 'website';

  late final FormGroup _form;
  late Map<String, String> _initialValues;

  @override
  void initState() {
    super.initState();
    final c = widget.contact;
    _form = FormGroup({
      _fieldEmail: FormControl<String>(
        value: c.email,
        validators: [Validators.email],
      ),
      _fieldPhone: FormControl<String>(value: c.phone),
      _fieldWebsite: FormControl<String>(value: c.website),
    });
    _initialValues = _snapshot();
  }

  Map<String, String> _snapshot() {
    return {
      for (final key in _form.controls.keys)
        key: ((_form.control(key).value as String?) ?? '').trim(),
    };
  }

  bool get _hasChanges {
    for (final entry in _initialValues.entries) {
      final current =
          ((_form.control(entry.key).value as String?) ?? '').trim();
      if (current != entry.value) return true;
    }
    return false;
  }

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
    context.read<CompanyContactBloc>().add(
          CompanyContactUpdateRequested(
            email: (_form.control(_fieldEmail).value as String? ?? '').trim(),
            phone: (_form.control(_fieldPhone).value as String? ?? '').trim(),
            website:
                (_form.control(_fieldWebsite).value as String? ?? '').trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyContactBloc, CompanyContactState>(
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
                AppStrings.companyInfoDescription,
                style: AppTextStyles.s12w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.6),
                ),
              ),
              AppSpacing.xl.verticalSpace,
              AppReactiveTextField.email(
                formControlName: _fieldEmail,
                title: AppStrings.companyInfoFieldEmail,
              ),
              AppSpacing.md.verticalSpace,
              AppReactiveTextField.phone(
                formControlName: _fieldPhone,
                title: AppStrings.companyInfoFieldPhone,
              ),
              AppSpacing.md.verticalSpace,
              AppReactiveTextField.text(
                formControlName: _fieldWebsite,
                title: AppStrings.companyInfoFieldWebsite,
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
                      AppStrings.companyInfoSaveButton,
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
