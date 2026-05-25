import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_overview_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_shimmer_widget.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<DashboardBloc>()..add(const DashboardEvent.started()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return StatusBuilder<DashboardEntity>(
            state: state.overviewState,
            loading: () => const DashboardShimmerWidget(),
            onRefresh: () async {
              context.read<DashboardBloc>().add(
                const DashboardEvent.overviewRequested(),
              );
            },
            success: (overview) => DashboardOverviewSection(overview: overview),
          );
        },
      ),
    );
  }
}
