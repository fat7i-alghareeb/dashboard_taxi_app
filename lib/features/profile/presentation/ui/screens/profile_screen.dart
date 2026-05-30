import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/profile/domain/entities/profile_entity.dart';
import 'package:dashboardtaxi/features/profile/presentation/states/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.isAdmin});

  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ProfileBloc>()..add(ProfileLoadRequested(isAdmin: isAdmin)),
      child: _ProfileBody(isAdmin: isAdmin),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.isAdmin});

  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listenWhen: (a, b) => a.updateStatus != b.updateStatus,
      listener: (context, state) {
        if (state.updateStatus.isSuccess) {
          showSuccessOverlay(context, AppStrings.profileSavedSuccess);
          context.read<ProfileBloc>().add(ProfileUpdateAcknowledged());
        } else if (state.updateStatus.isFailed) {
          showErrorOverlay(
            context,
            state.updateStatus.errorMessage ?? AppStrings.somethingWentWrong,
          );
          context.read<ProfileBloc>().add(ProfileUpdateAcknowledged());
        }
      },
      builder: (context, state) {
        return StatusBuilder<ProfileEntity>(
          state: state.loadStatus,
          errorMessage: AppStrings.profileLoadFailed,
          onError: () => context
              .read<ProfileBloc>()
              .add(ProfileLoadRequested(isAdmin: isAdmin)),
          success: (profile) => _ProfileForm(
            profile: profile,
            isAdmin: isAdmin,
            isSaving: state.updateStatus.isLoading,
          ),
        );
      },
    );
  }
}

class _ProfileForm extends StatefulWidget {
  const _ProfileForm({
    required this.profile,
    required this.isAdmin,
    required this.isSaving,
  });

  final ProfileEntity profile;
  final bool isAdmin;
  final bool isSaving;

  @override
  State<_ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<_ProfileForm> {
  static const _fieldName = 'name';
  static const _fieldEmail = 'email';
  static const _fieldPhone1 = 'phone1';
  static const _fieldPhone2 = 'phone2';

  late final FormGroup _form;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    if (widget.isAdmin) {
      _form = FormGroup({
        _fieldName: FormControl<String>(
          value: p.name,
          validators: [Validators.required],
        ),
        _fieldEmail: FormControl<String>(
          value: p.email ?? '',
          validators: [Validators.required, Validators.email],
        ),
        _fieldPhone1: FormControl<String>(value: p.phone ?? ''),
        _fieldPhone2: FormControl<String>(value: p.phone2 ?? ''),
      });
    } else {
      _form = FormGroup({
        _fieldName: FormControl<String>(
          value: p.name,
          validators: [Validators.required],
        ),
        _fieldEmail: FormControl<String>(
          value: p.email ?? '',
          validators: [Validators.email],
        ),
      });
    }
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
    final name = (_form.control(_fieldName).value as String).trim();
    final email = (_form.control(_fieldEmail).value as String?)?.trim();

    if (widget.isAdmin) {
      final phone1 = (_form.control(_fieldPhone1).value as String?)?.trim();
      final phone2 = (_form.control(_fieldPhone2).value as String?)?.trim();
      context.read<ProfileBloc>().add(
            ProfileAdminUpdateRequested(
              name: name,
              email: email ?? '',
              phone1: phone1?.isEmpty == true ? null : phone1,
              phone2: phone2?.isEmpty == true ? null : phone2,
            ),
          );
    } else {
      context.read<ProfileBloc>().add(
            ProfileDriverUpdateRequested(
              name: name,
              email: email?.isEmpty == true ? null : email,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.profile;
    return ReactiveForm(
      formGroup: _form,
      child: SingleChildScrollView(
        padding: REdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(profile: p),
            AppSpacing.xl.verticalSpace,
            _SectionTitle(title: AppStrings.profileSectionAccount),
            AppSpacing.md.verticalSpace,
            AppReactiveTextField.text(
              formControlName: _fieldName,
              title: AppStrings.profileFieldName,
              isRequired: true,
            ),
            AppSpacing.md.verticalSpace,
            AppReactiveTextField.email(
              formControlName: _fieldEmail,
              title: AppStrings.profileFieldEmail,
              isRequired: widget.isAdmin,
            ),
            if (widget.isAdmin) ...[
              AppSpacing.md.verticalSpace,
              AppReactiveTextField.phone(
                formControlName: _fieldPhone1,
                title: AppStrings.profileFieldPhone,
              ),
              AppSpacing.md.verticalSpace,
              AppReactiveTextField.phone(
                formControlName: _fieldPhone2,
                title: AppStrings.profileFieldPhone2,
              ),
            ] else ...[
              AppSpacing.md.verticalSpace,
              _ReadOnlyTile(
                label: AppStrings.profileFieldPhone,
                value: p.phone ?? '—',
              ),
            ],
            if (!widget.isAdmin) ...[
              AppSpacing.xl.verticalSpace,
              _SectionTitle(title: AppStrings.profileSectionDriverDetails),
              AppSpacing.md.verticalSpace,
              if (p.licenseNumber != null)
                _ReadOnlyTile(
                  label: AppStrings.profileFieldLicense,
                  value: p.licenseNumber!,
                ),
              if (p.vehicleTypeName != null) ...[
                AppSpacing.sm.verticalSpace,
                _ReadOnlyTile(
                  label: AppStrings.profileFieldVehicleType,
                  value: p.vehicleTypeName!,
                ),
              ],
              if (p.approvalStatus != null) ...[
                AppSpacing.sm.verticalSpace,
                _ReadOnlyTile(
                  label: AppStrings.profileFieldApprovalStatus,
                  value: p.approvalStatus!,
                ),
              ],
            ],
            AppSpacing.xl.verticalSpace,
            AppButton.primary(
              isLoading: widget.isSaving,
              layout: const AppButtonLayout(height: 52),
              onTap: () => _submit(context),
              child: AppButtonChild.label(
                AppStrings.profileSaveButton,
                textStyle: AppTextStyles.s14w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.profile});
  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56.r,
          height: 56.r,
          decoration: BoxDecoration(
            color: context.primary.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: FaIcon(
              profile.isAdmin
                  ? FontAwesomeIcons.userTie
                  : FontAwesomeIcons.userGear,
              size: 22.r,
              color: context.primary,
            ),
          ),
        ),
        AppSpacing.md.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                profile.name,
                style: AppTextStyles.s18w600.copyWith(color: context.onSurface),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              4.verticalSpace,
              Text(
                profile.role,
                style: AppTextStyles.s12w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.s11w500.copyWith(
        color: context.onSurface.withValues(alpha: 0.55),
        letterSpacing: 1.2,
      ),
    );
  }
}

class _ReadOnlyTile extends StatelessWidget {
  const _ReadOnlyTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
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
              label,
              style: AppTextStyles.s12w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
          AppSpacing.sm.horizontalSpace,
          Flexible(
            child: Text(
              value,
              style:
                  AppTextStyles.s14w500.copyWith(color: context.onSurface),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
