import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/chat/presentation/ui/widgets/chat_entry_button.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_divider_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_overview_label_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_status_chip_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_detail_info_row_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_stops_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_timeline_widget.dart';

class DashboardTripDetailsBodyWidget extends StatelessWidget {
  const DashboardTripDetailsBodyWidget({super.key, required this.details});

  final DashboardTripDetailsEntity details;

  /// The admin can chat only while the trip is live. Status is the backend
  /// TripStatus enum name (e.g. "InProgress", "Completed").
  static bool _isActiveTrip(String status) {
    const terminal = {'completed', 'cancelled', 'refunded', 'paymentfailed'};
    return !terminal.contains(status.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                details.referenceCode,
                style: AppTextStyles.s20w700.copyWith(color: context.onSurface),
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            DashboardStatusChipWidget(
              label: dashboardTripStatusLabel(details.status),
              tone: dashboardToneFromTripStatus(details.status),
            ),
          ],
        ),
        AppSpacing.xs.verticalSpace,
        Text(
          details.fareLabel,
          style: AppTextStyles.s14w500.copyWith(color: context.primary),
        ),
        if (details.scheduledAt != null) ...[
          AppSpacing.sm.verticalSpace,
          Wrap(
            spacing: AppSpacing.sm.w,
            runSpacing: AppSpacing.xs.h,
            children: [
              DashboardStatusChipWidget(
                label: AppStrings.scheduledForLabel.trParams({
                  'when': details.scheduledAt!.toLocal().toSmartDateTime(),
                }),
                tone: _attentionTone(details.attentionState),
                icon: FontAwesomeIcons.clock,
                dense: true,
              ),
              if (details.status.toLowerCase() == 'accepted')
                DashboardStatusChipWidget(
                  label: details.canMarkEnRoute
                      ? AppStrings.tripStartEnRouteNavigation
                      : AppStrings.scheduledNotReadyShort.trParams({
                          'when':
                              (details.dispatchWindowOpensAt ??
                                      details.scheduledAt!)
                                  .toLocal()
                                  .toSmartDateTime(),
                        }),
                  tone: details.canMarkEnRoute
                      ? DashboardStatusTone.success
                      : DashboardStatusTone.info,
                  dense: true,
                ),
            ],
          ),
        ],
        if (_isActiveTrip(details.status)) ...[
          AppSpacing.md.verticalSpace,
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: ChatEntryButton(tripId: details.id),
          ),
        ],
        if (details.waitingFeeLabel != null) ...[
          AppSpacing.xs.verticalSpace,
          Text(
            'Waiting fee: ${details.waitingFeeLabel}',
            style: AppTextStyles.s12w500.copyWith(color: AppColors.warning),
          ),
        ],
        if (details.isAirport &&
            details.flightNumber?.trim().isNotEmpty == true) ...[
          AppSpacing.md.verticalSpace,
          Container(
            padding: REdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: context.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppRadii.md.r),
              border: Border.all(
                color: context.primary.withValues(alpha: 0.20),
              ),
            ),
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.planeArrival, color: context.primary),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: DashboardTripDetailInfoRowWidget(
                    label: AppStrings.airportPickup,
                    value:
                        '${AppStrings.flightNumber}: ${details.flightNumber!.trim()}',
                  ),
                ),
              ],
            ),
          ),
        ],
        AppSpacing.lg.verticalSpace,
        const DashboardDividerWidget(),
        AppSpacing.lg.verticalSpace,
        LayoutBuilder(
          builder: (context, constraints) {
            const spacing = AppSpacing.lg;
            final tile = (constraints.maxWidth - spacing.w) / 2;
            final tiles = <Widget>[
              DashboardTripDetailInfoRowWidget(
                label: AppStrings.dashboardPassenger,
                value: details.passengerName,
              ),
              DashboardTripDetailInfoRowWidget(
                label: AppStrings.phoneNumber,
                value: details.passengerPhone,
              ),
              DashboardTripDetailInfoRowWidget(
                label: details.acceptedAdminName != null
                    ? 'Accepted owner'
                    : AppStrings.dashboardDriver,
                value:
                    details.acceptedAdminName ??
                    details.driverName ??
                    AppStrings.dashboardUnknownDriver,
              ),
              DashboardTripDetailInfoRowWidget(
                label: AppStrings.tripVehicleType,
                value: details.vehicleTypeName,
              ),
            ];
            return Wrap(
              spacing: spacing.w,
              runSpacing: spacing.h,
              children: [
                for (final t in tiles) SizedBox(width: tile, child: t),
              ],
            );
          },
        ),
        if (details.cancellation != null) ...[
          AppSpacing.xl.verticalSpace,
          const DashboardOverviewLabelWidget(label: 'Cancellation'),
          AppSpacing.md.verticalSpace,
          _CancellationSection(cancellation: details.cancellation!),
        ],
        AppSpacing.xl.verticalSpace,
        if (details.passengerNote?.trim().isNotEmpty == true) ...[
          DashboardOverviewLabelWidget(
            label: AppStrings.dashboardPassengerNote,
          ),
          AppSpacing.md.verticalSpace,
          _PassengerNoteSection(note: details.passengerNote!.trim()),
          AppSpacing.xl.verticalSpace,
        ],
        DashboardOverviewLabelWidget(label: AppStrings.dashboardRouteSummary),
        AppSpacing.md.verticalSpace,
        DashboardTripStopsWidget(details: details),
        AppSpacing.xl.verticalSpace,
        DashboardOverviewLabelWidget(label: AppStrings.dashboardLifecycle),
        AppSpacing.md.verticalSpace,
        DashboardTripTimelineWidget(details: details),
      ],
    );
  }

  DashboardStatusTone _attentionTone(String attentionState) {
    return switch (attentionState.toLowerCase()) {
      'overdue' => DashboardStatusTone.error,
      'urgent' => DashboardStatusTone.warning,
      'duesoon' => DashboardStatusTone.info,
      _ => DashboardStatusTone.neutral,
    };
  }
}

class _PassengerNoteSection extends StatelessWidget {
  const _PassengerNoteSection({required this.note});

  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        border: Border.all(color: context.primary.withValues(alpha: 0.14)),
      ),
      child: Text(
        note,
        style: AppTextStyles.s14w500.copyWith(
          color: context.onSurface,
          height: 1.35,
        ),
      ),
    );
  }
}

class _CancellationSection extends StatelessWidget {
  const _CancellationSection({required this.cancellation});

  final DashboardCancellationEntity cancellation;

  static String _humanize(String value) => value.replaceAllMapped(
    RegExp(r'([a-z])([A-Z])'),
    (m) => '${m[1]} ${m[2]}',
  );

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[
      DashboardTripDetailInfoRowWidget(
        label: 'Cancelled by',
        value: _humanize(cancellation.actor),
      ),
      DashboardTripDetailInfoRowWidget(
        label: 'Reason',
        value: _humanize(cancellation.reason),
      ),
      DashboardTripDetailInfoRowWidget(
        label: 'Refund',
        value: cancellation.refundLabel,
      ),
      if (cancellation.createdAt != null)
        DashboardTripDetailInfoRowWidget(
          label: 'Cancelled at',
          value: cancellation.createdAt!.toSmartDateTime(),
        ),
    ];

    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.error.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        border: Border.all(color: context.error.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) AppSpacing.md.verticalSpace,
            rows[i],
          ],
          if (cancellation.note?.trim().isNotEmpty == true) ...[
            AppSpacing.md.verticalSpace,
            DashboardTripDetailInfoRowWidget(
              label: 'Note',
              value: cancellation.note!.trim(),
            ),
          ],
        ],
      ),
    );
  }
}
