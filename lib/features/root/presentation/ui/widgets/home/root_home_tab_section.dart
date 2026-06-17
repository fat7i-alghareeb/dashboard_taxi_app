import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/core/domain/extensions/user_role_extensions.dart';
import 'package:dashboardtaxi/core/services/session/auth_manager.dart';
import 'package:dashboardtaxi/features/driver_home/presentation/states/driver_home_bloc.dart';
import 'package:dashboardtaxi/features/driver_home/presentation/ui/widgets/driver_home_controls_panel_widget.dart';
import 'package:dashboardtaxi/features/root/constants/root_constants.dart';
import 'package:dashboardtaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:dashboardtaxi/features/root/presentation/states/root_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_sheet_stage.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/sheet/trip_sheet_section.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_status_chip_widget.dart';

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
            onError: () => context.read<RootBloc>().add(
              const RootEvent.mapBootstrapRequested(),
            ),
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
      ],
    );
  }
}

/// The bottom trip sheet (swaps between idle controls and trip stages).
class _HomeBottomSheet extends StatefulWidget {
  @override
  State<_HomeBottomSheet> createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<_HomeBottomSheet> {
  bool _isCollapsed = false;

  void _setCollapsed(bool value) {
    if (_isCollapsed == value) return;
    setState(() => _isCollapsed = value);
  }

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
        return BlocConsumer<TripBloc, TripState>(
          listenWhen: (previous, current) =>
              previous.activeTrip?.id != current.activeTrip?.id ||
              previous.completedTrip?.id != current.completedTrip?.id ||
              previous.sheetStage != current.sheetStage,
          listener: (context, state) {
            if (_isCollapsed) _setCollapsed(false);
          },
          buildWhen: (previous, current) =>
              previous.activeTrip?.id != current.activeTrip?.id ||
              previous.activeTrip?.status != current.activeTrip?.status ||
              previous.completedTrip?.id != current.completedTrip?.id ||
              previous.sheetStage != current.sheetStage,
          builder: (context, tripState) {
            final stage = tripState.sheetStage;
            final hasTripSheet = stage != TripSheetStage.idle;

            if (_isCollapsed && hasTripSheet) {
              return _CollapsedTripSheetPill(
                state: tripState,
                onExpand: () => _setCollapsed(false),
              );
            }

            return TripSheetSection(
              onCollapse: hasTripSheet ? () => _setCollapsed(true) : null,
              idleBuilder: isDriver
                  ? (ctx) => Padding(
                      padding: REdgeInsets.symmetric(horizontal: AppSpacing.sm),
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
      },
    );
  }
}

class _CollapsedTripSheetPill extends StatelessWidget {
  const _CollapsedTripSheetPill({required this.state, required this.onExpand});

  final TripState state;
  final VoidCallback onExpand;

  @override
  Widget build(BuildContext context) {
    final trip = state.completedTrip ?? state.activeTrip;
    final reference = trip?.referenceCode ?? AppStrings.tripActiveRide;

    return SafeArea(
      top: false,
      child: Padding(
        padding: REdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Material(
          color: context.colorScheme.surface,
          elevation: 12,
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            onTap: onExpand,
            child: Padding(
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Tooltip(
                    message: AppStrings.expandTripSheet,
                    child: Container(
                      width: 42.r,
                      height: 42.r,
                      decoration: BoxDecoration(
                        color: context.primary.withValues(alpha: 0.16),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.keyboard_arrow_up_rounded,
                          size: 26.r,
                          color: context.primary,
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.md.horizontalSpace,
                  Expanded(
                    child: Text(
                      reference,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s14w600.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                  ),
                  if (trip != null) ...[
                    AppSpacing.sm.horizontalSpace,
                    TripStatusChipWidget(status: trip.status),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
