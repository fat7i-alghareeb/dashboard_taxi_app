import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_admin_operations_content_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_admin_operations_header_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_shimmer_widget.dart';

class DashboardAdminOperationsBody extends StatelessWidget {
  const DashboardAdminOperationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardBloc>()
        ..add(const DashboardEvent.adminOperationsRequested()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<DashboardBloc>().add(
                const DashboardEvent.adminOperationsRequested(),
              );
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              children: [
                const DashboardAdminOperationsHeaderWidget(),
                AppSpacing.xl.verticalSpace,
                StatusBuilder<DashboardAdminOperationsEntity>(
                  state: state.adminOperationsState,
                  loading: () => const DashboardShimmerWidget(),
                  success: (operations) =>
                      DashboardAdminOperationsContentWidget(
                        operations: operations,
                        isActionLoading: state.adminActionState.isLoading,
                      ),
                ),
                AppSpacing.xxl.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}
