import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/core/domain/extensions/user_role_extensions.dart';
import 'package:dashboardtaxi/core/services/session/auth_manager.dart';
import 'package:dashboardtaxi/features/driver_home/presentation/states/driver_home_bloc.dart';
import 'package:dashboardtaxi/features/driver_home/presentation/ui/widgets/driver_home_connection_pill_widget.dart';
import 'package:dashboardtaxi/features/driver_home/presentation/ui/widgets/driver_home_controls_panel_widget.dart';
import 'package:dashboardtaxi/features/root/constants/root_constants.dart';
import 'package:dashboardtaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:dashboardtaxi/features/root/presentation/states/root_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/sheet/trip_sheet_section.dart';

import '../map/root_map_loading_section.dart';
import '../map/root_map_section.dart';

class RootHomeTabSection extends StatelessWidget {
  const RootHomeTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<DriverHomeBloc>()..add(const DriverHomeEvent.started()),
        ),
      ],
      child: BlocBuilder<RootBloc, RootState>(
        buildWhen: (prev, curr) =>
            prev.mapBootstrapState != curr.mapBootstrapState,
        builder: (context, state) {
          return StatusBuilder<RootMapLocationEntity>(
            state: state.mapBootstrapState,
            errorMessage: AppStrings.rootMapInitializationFailed,
            init: () => const RootMapLoadingSection(),
            loading: () => const RootMapLoadingSection(),
            onError: () => context
                .read<RootBloc>()
                .add(const RootEvent.mapBootstrapRequested()),
            success: (location) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  RootMapSection(initialLocation: location),
                  const _HomeTopOverlay(),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: _HomeBottomSheet(),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

/// Hamburger button (top-left) + connection pill (top-center).
class _HomeTopOverlay extends StatelessWidget {
  const _HomeTopOverlay();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: SafeArea(
            child: Padding(
              padding: REdgeInsets.all(AppSpacing.md),
              child: AppButton.variant(
                variant: AppButtonVariant.grey,
                fill: AppButtonFill.solid,
                onTap: () => Scaffold.maybeOf(context)?.openDrawer(),
                layout: AppButtonLayout(
                  shape: AppButtonShape.circle,
                  height: RootConstants.headerMenuSize.sp,
                  backgroundColor: context.surface,
                  contentPadding: REdgeInsets.all(AppSpacing.sm),
                ),
                customShadows: context.shadows.grey,
                child: AppButtonChild.icon(
                  IconSource.builder(
                    (ctx) => FaIcon(
                      FontAwesomeIcons.bars,
                      size: 18.r,
                      color: ctx.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        BlocBuilder<DriverHomeBloc, DriverHomeState>(
          buildWhen: (p, c) => p.connectionState != c.connectionState,
          builder: (context, state) => Positioned(
            top: AppSpacing.md.h,
            left: 0,
            right: 0,
            child: Center(
              child: DriverHomeConnectionPillWidget(
                connectionState: state.connectionState,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// The bottom trip sheet (swaps between idle controls and trip stages).
class _HomeBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDriver = getIt<AuthManager>().currentUser.isDriver;

    return BlocConsumer<DriverHomeBloc, DriverHomeState>(
      listener: (context, state) {
        state.statusState.maybeWhen(
          loading: () => showLoadingOverlay(context, AppStrings.uploading),
          success: (_) {
            clearAllOverlays();
            showSuccessOverlay(
              context,
              state.isOnline
                  ? AppStrings.driverNowOnline
                  : AppStrings.driverNowOffline,
            );
          },
          failure: (msg) {
            clearAllOverlays();
            showErrorOverlay(context, msg);
          },
          orElse: () {},
        );
      },
      builder: (context, homeState) {
        return TripSheetSection(
          idleBuilder: isDriver
              ? (ctx) => Padding(
                    padding: REdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                    child: DriverHomeControlsPanelWidget(
                      state: homeState,
                      isOnline: homeState.isOnline,
                      isLoading: homeState.statusState.isLoading,
                    ),
                  )
              : null,
        );
      },
    );
  }
}
