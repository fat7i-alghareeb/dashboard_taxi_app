import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_driver_document_card_widget.dart';

class DashboardDocumentReviewListWidget extends StatelessWidget {
  const DashboardDocumentReviewListWidget({
    super.key,
    required this.driver,
    required this.documents,
    required this.state,
  });

  final DashboardDriverEntity driver;
  final List<DashboardDriverDocumentEntity> documents;
  final DashboardState state;

  @override
  Widget build(BuildContext context) {
    final allApproved =
        documents.isNotEmpty &&
        documents.every(
          (document) => document.status.toLowerCase() == 'approved',
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...documents.map(
          (document) => Padding(
            padding: REdgeInsets.only(bottom: AppSpacing.md),
            child: DashboardDriverDocumentCardWidget(
              driver: driver,
              document: document,
              state: state,
            ),
          ),
        ),
        AppSpacing.sm.verticalSpace,
        AppButton.success(
          isActive: allApproved,
          isLoading: state.driverApprovalState.isLoading,
          onTap: () {
            context.read<DashboardBloc>().add(
              DashboardEvent.driverApprovalRequested(driver.id),
            );
          },
          child: AppButtonChild.labelIcon(
            label: AppStrings.dashboardApproveDriver,
            icon: IconSource.widget(const FaIcon(FontAwesomeIcons.circleCheck)),
          ),
        ),
      ],
    );
  }
}
