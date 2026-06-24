import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/support_contact/domain/entities/support_contact_entity.dart';
import 'package:dashboardtaxi/features/support_contact/presentation/states/support_contact_bloc.dart';

/// Admin-only screen to edit the support WhatsApp number used by the customer
/// app's in-trip "Report problem" action.
class SupportContactScreen extends StatelessWidget {
  const SupportContactScreen({super.key});

  static const String pagePath = '/support-contact';
  static const String pageName = 'SupportContactScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<SupportContactBloc>()..add(SupportContactLoadRequested()),
      child: const _SupportContactBody(),
    );
  }
}

class _SupportContactBody extends StatelessWidget {
  const _SupportContactBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupportContactBloc, SupportContactState>(
      listenWhen: (a, b) => a.updateStatus != b.updateStatus,
      listener: (context, state) {
        if (state.updateStatus.isSuccess) {
          showSuccessOverlay(context, AppStrings.supportContactSavedSuccess);
          context
              .read<SupportContactBloc>()
              .add(SupportContactUpdateAcknowledged());
        } else if (state.updateStatus.isFailed) {
          showErrorOverlay(
            context,
            state.updateStatus.errorMessage ?? AppStrings.somethingWentWrong,
          );
          context
              .read<SupportContactBloc>()
              .add(SupportContactUpdateAcknowledged());
        }
      },
      builder: (context, state) {
        return AppScaffold.appBar(
          appBarConfig: AppScaffoldAppBarConfig(
            title: AppStrings.supportContactTitle,
            subtitle: AppStrings.supportContactSubtitle,
          ),
          child: StatusBuilder<SupportContactEntity>(
            state: state.loadStatus,
            errorMessage: AppStrings.supportContactLoadFailed,
            onError: () => context
                .read<SupportContactBloc>()
                .add(SupportContactLoadRequested()),
            success: (contact) => _SupportContactForm(
              contact: contact,
              isSaving: state.updateStatus.isLoading,
            ),
          ),
        );
      },
    );
  }
}

class _SupportContactForm extends StatefulWidget {
  const _SupportContactForm({required this.contact, required this.isSaving});

  final SupportContactEntity contact;
  final bool isSaving;

  @override
  State<_SupportContactForm> createState() => _SupportContactFormState();
}

class _SupportContactFormState extends State<_SupportContactForm> {
  static const _fieldWhatsApp = 'whatsApp';

  late final FormGroup _form;
  late String _initialValue;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      _fieldWhatsApp: FormControl<String>(value: widget.contact.whatsApp),
    });
    _initialValue = _current();
  }

  String _current() =>
      ((_form.control(_fieldWhatsApp).value as String?) ?? '').trim();

  bool get _hasChanges => _current() != _initialValue;

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
    context.read<SupportContactBloc>().add(
      SupportContactUpdateRequested(whatsApp: _current()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SupportContactBloc, SupportContactState>(
      listenWhen: (a, b) => a.updateStatus != b.updateStatus,
      listener: (context, state) {
        if (state.updateStatus.isSuccess) {
          setState(() => _initialValue = _current());
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
                AppStrings.supportContactDescription,
                style: AppTextStyles.s12w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.6),
                ),
              ),
              AppSpacing.xl.verticalSpace,
              AppReactiveTextField.phone(
                formControlName: _fieldWhatsApp,
                title: AppStrings.supportContactFieldWhatsApp,
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
                      AppStrings.supportContactSaveButton,
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
