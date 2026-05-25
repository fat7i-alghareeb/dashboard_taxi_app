import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_document_status_chip_widget.dart';

class DashboardDriverDocumentCardWidget extends StatelessWidget {
  const DashboardDriverDocumentCardWidget({
    super.key,
    required this.driver,
    required this.document,
    required this.state,
  });

  final DashboardDriverEntity driver;
  final DashboardDriverDocumentEntity document;
  final DashboardState state;

  @override
  Widget build(BuildContext context) {
    final isReviewed =
        document.status.toLowerCase() == 'approved' ||
        document.status.toLowerCase() == 'rejected';
    final isBusy = state.documentReviewState.isLoading;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadii.sm.r),
                  child: AppImageViewer.network(
                    document.fileUrl,
                    width: 64.w,
                    height: 64.h,
                    borderRadius: AppRadii.sm,
                    enableFullScreen: true,
                  ),
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _documentTypeLabel(document.type),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.s14w600.copyWith(
                          color: context.onSurface,
                        ),
                      ),
                      AppSpacing.xs.verticalSpace,
                      DashboardDocumentStatusChipWidget(
                        status: document.status,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!document.reviewNotes.isNullOrBlank) ...[
              AppSpacing.md.verticalSpace,
              Text(
                document.reviewNotes!,
                style: AppTextStyles.s12w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.64),
                ),
              ),
            ],
            AppSpacing.md.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: AppButton.success(
                    isActive: !isReviewed,
                    isLoading: isBusy,
                    onTap: () => _review(context, approved: true),
                    child: AppButtonChild.label(
                      AppStrings.dashboardApproveDocument,
                    ),
                  ),
                ),
                AppSpacing.sm.horizontalSpace,
                Expanded(
                  child: AppButton.error(
                    isActive: !isReviewed,
                    isLoading: isBusy,
                    onTap: () => _review(context, approved: false),
                    child: AppButtonChild.label(
                      AppStrings.dashboardRejectDocument,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _review(BuildContext context, {required bool approved}) {
    context.read<DashboardBloc>().add(
      DashboardEvent.documentReviewRequested(
        driverId: driver.id,
        documentId: document.id,
        approved: approved,
        notes: approved ? null : AppStrings.dashboardRejectedByAdminNote,
      ),
    );
  }

  String _documentTypeLabel(String type) {
    return switch (type) {
      'DriversLicense' => AppStrings.driversLicense,
      'NationalId' => AppStrings.nationalId,
      'VehicleRegistration' => AppStrings.vehicleRegistration,
      'Insurance' || 'VehicleInsurance' => AppStrings.vehicleInsurance,
      _ => type,
    };
  }
}
