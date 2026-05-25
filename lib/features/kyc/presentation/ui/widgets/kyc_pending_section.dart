import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/kyc/constants/forms/kyc_forms.dart';
import 'package:dashboardtaxi/features/kyc/domain/entities/kyc_document_entity.dart';
import 'package:dashboardtaxi/features/kyc/presentation/states/kyc_bloc.dart';
import 'kyc_upload_slot_widget.dart';

class KycPendingSection extends StatelessWidget {
  const KycPendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycBloc, KycState>(
      builder: (context, state) {
        return StatusBuilder<List<KycDocumentEntity>>(
          state: state.fetchState,
          onRefresh: () async {
            context.read<KycBloc>().add(KycEvent.started(state.driverId));
          },
          success: (docs) {
            return ReactiveForm(
              formGroup: state.form,
              child: SingleChildScrollView(
                padding: REdgeInsets.all(AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacing.md.verticalSpace,
                    Text(
                      AppStrings.kycTitle,
                      style: AppTextStyles.s24w700.copyWith(color: context.onSurface),
                    ),
                    AppSpacing.sm.verticalSpace,
                    Text(
                      AppStrings.kycPendingSubtitle,
                      style: AppTextStyles.s14w400.copyWith(
                        color: context.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    AppSpacing.xl.verticalSpace,

                    // 2x2 Responsive Upload Grid
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: AppSpacing.md.w,
                      mainAxisSpacing: AppSpacing.md.h,
                      childAspectRatio: 1.3,
                      children: [
                        // Slot 1: Drivers License
                        ReactiveValueListenableBuilder<String>(
                          formControlName: KycForms.licenseField,
                          builder: (context, control, _) {
                            final isUploading = state.uploadState.isLoading &&
                                state.uploadingType == 'DriversLicense';
                            return KycUploadSlotWidget(
                              type: 'DriversLicense',
                              label: AppStrings.driversLicense,
                              fileUrl: control.value,
                              isUploading: isUploading,
                            );
                          },
                        ),
                        // Slot 2: National ID
                        ReactiveValueListenableBuilder<String>(
                          formControlName: KycForms.idField,
                          builder: (context, control, _) {
                            final isUploading = state.uploadState.isLoading &&
                                state.uploadingType == 'NationalId';
                            return KycUploadSlotWidget(
                              type: 'NationalId',
                              label: AppStrings.nationalId,
                              fileUrl: control.value,
                              isUploading: isUploading,
                            );
                          },
                        ),
                        // Slot 3: Vehicle Registration
                        ReactiveValueListenableBuilder<String>(
                          formControlName: KycForms.registrationField,
                          builder: (context, control, _) {
                            final isUploading = state.uploadState.isLoading &&
                                state.uploadingType == 'VehicleRegistration';
                            return KycUploadSlotWidget(
                              type: 'VehicleRegistration',
                              label: AppStrings.vehicleRegistration,
                              fileUrl: control.value,
                              isUploading: isUploading,
                            );
                          },
                        ),
                        // Slot 4: Vehicle Insurance
                        ReactiveValueListenableBuilder<String>(
                          formControlName: KycForms.insuranceField,
                          builder: (context, control, _) {
                            final isUploading = state.uploadState.isLoading &&
                                state.uploadingType == 'Insurance';
                            return KycUploadSlotWidget(
                              type: 'Insurance',
                              label: AppStrings.vehicleInsurance,
                              fileUrl: control.value,
                              isUploading: isUploading,
                            );
                          },
                        ),
                      ],
                    ),
                    AppSpacing.xxl.verticalSpace,

                    // Submit CTA Button
                    ReactiveFormConsumer(
                      builder: (context, form, _) {
                        return AppButton.primaryGradient(
                          child: AppButtonChild.label(AppStrings.kycSubmit),
                          isActive: form.valid,
                          onTap: () {
                            context.read<KycBloc>().add(
                                  const KycEvent.refreshStatusRequested(),
                                );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
