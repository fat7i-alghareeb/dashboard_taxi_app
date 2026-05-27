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
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: REdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.lg,
                ),
                children: [
                  Row(
                    children: [
                      Container(
                        width: 6.r,
                        height: 6.r,
                        decoration: BoxDecoration(
                          color: context.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      AppSpacing.sm.horizontalSpace,
                      Text(
                        AppStrings.kycTitle.toUpperCase(),
                        style: AppTextStyles.s11w500.copyWith(
                          color: context.primary,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.md.verticalSpace,
                  Text(
                    AppStrings.kycTitle,
                    style: AppTextStyles.s24w700.copyWith(
                      color: context.onSurface,
                      height: 1.15,
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  Text(
                    AppStrings.kycPendingSubtitle,
                    style: AppTextStyles.s14w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.60),
                    ),
                  ),
                  AppSpacing.xl.verticalSpace,
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: AppSpacing.md.w,
                    mainAxisSpacing: AppSpacing.md.h,
                    childAspectRatio: 1.2,
                    children: [
                      ReactiveValueListenableBuilder<String>(
                        formControlName: KycForms.licenseField,
                        builder: (context, control, _) {
                          final isUploading =
                              state.uploadState.isLoading &&
                              state.uploadingType == 'DriversLicense';
                          return KycUploadSlotWidget(
                            type: 'DriversLicense',
                            label: AppStrings.driversLicense,
                            fileUrl: control.value,
                            isUploading: isUploading,
                          );
                        },
                      ),
                      ReactiveValueListenableBuilder<String>(
                        formControlName: KycForms.idField,
                        builder: (context, control, _) {
                          final isUploading =
                              state.uploadState.isLoading &&
                              state.uploadingType == 'NationalId';
                          return KycUploadSlotWidget(
                            type: 'NationalId',
                            label: AppStrings.nationalId,
                            fileUrl: control.value,
                            isUploading: isUploading,
                          );
                        },
                      ),
                      ReactiveValueListenableBuilder<String>(
                        formControlName: KycForms.registrationField,
                        builder: (context, control, _) {
                          final isUploading =
                              state.uploadState.isLoading &&
                              state.uploadingType == 'VehicleRegistration';
                          return KycUploadSlotWidget(
                            type: 'VehicleRegistration',
                            label: AppStrings.vehicleRegistration,
                            fileUrl: control.value,
                            isUploading: isUploading,
                          );
                        },
                      ),
                      ReactiveValueListenableBuilder<String>(
                        formControlName: KycForms.insuranceField,
                        builder: (context, control, _) {
                          final isUploading =
                              state.uploadState.isLoading &&
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
                  ReactiveFormConsumer(
                    builder: (context, form, _) {
                      return AppButton.primary(
                        child: AppButtonChild.label(AppStrings.kycSubmit),
                        isActive: form.valid,
                        layout: const AppButtonLayout(height: 52),
                        onTap: () {
                          context.read<KycBloc>().add(
                            const KycEvent.refreshStatusRequested(),
                          );
                        },
                      );
                    },
                  ),
                  AppSpacing.xxl.verticalSpace,
                ],
              ),
            );
          },
        );
      },
    );
  }
}
