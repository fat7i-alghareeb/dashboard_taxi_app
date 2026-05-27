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
            Row(
              children: [
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.primary.withValues(alpha: 0.10),
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.solidUser,
                      size: 16.r,
                      color: context.primary,
                    ),
                  ),
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver.fullName.isEmpty ? driver.id : driver.fullName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.s16w600.copyWith(
                          color: context.onSurface,
                        ),
                      ),
                      AppSpacing.xs.verticalSpace,
                      Text(
                        '${AppStrings.dashboardLicenseNumber}: ${driver.licenseNumber}',
                        style: AppTextStyles.s12w400.copyWith(
                          color: context.onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
