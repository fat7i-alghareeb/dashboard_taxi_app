import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_document_review_list_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_documents_shimmer_widget.dart';

class DashboardKycReviewSheet extends StatelessWidget {
  const DashboardKycReviewSheet({super.key, required this.driver});

  final DashboardDriverEntity driver;

  static Future<void> show(
    BuildContext context,
    DashboardDriverEntity driver,
  ) async {
    final bloc = context.read<DashboardBloc>()
      ..add(DashboardEvent.driverDocumentsRequested(driver.id));

    await AppBottomSheet.show<void>(
      context,
      sheet: AppBottomSheet.basic(
        title: AppStrings.dashboardKycReviewTitle,
        child: BlocProvider.value(
          value: bloc,
          child: DashboardKycReviewSheet(driver: driver),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              driver.fullName.isEmpty ? driver.id : driver.fullName,
              style: AppTextStyles.s18w600.copyWith(color: context.onSurface),
            ),
            AppSpacing.xs.verticalSpace,
            Text(
              '${AppStrings.dashboardLicenseNumber}: ${driver.licenseNumber}',
              style: AppTextStyles.s14w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.64),
              ),
            ),
            AppSpacing.lg.verticalSpace,
            StatusBuilder<List<DashboardDriverDocumentEntity>>(
              state: state.driverDocumentsState,
              loading: () => const DashboardDocumentsShimmerWidget(),
              isEmpty: (documents) => documents.isEmpty,
              success: (documents) => DashboardDocumentReviewListWidget(
                driver: driver,
                documents: documents,
                state: state,
              ),
            ),
          ],
        );
      },
    );
  }
}
