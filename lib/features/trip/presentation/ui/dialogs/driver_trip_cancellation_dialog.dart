import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/dialogs/trip_cancel_reason_row_widget.dart';

class DriverTripCancellationDialog extends StatefulWidget {
  const DriverTripCancellationDialog({super.key, required this.tripId});

  final String tripId;

  static Future<void> show(BuildContext context, String tripId) {
    return AppDialog.show<void>(
      context,
      dialog: AppDialog.basic(
        child: DriverTripCancellationDialog(tripId: tripId),
      ),
    );
  }

  @override
  State<DriverTripCancellationDialog> createState() =>
      _DriverTripCancellationDialogState();
}

class _DriverTripCancellationDialogState
    extends State<DriverTripCancellationDialog> {
  static const _reasons = [
    'PassengerLate',
    'PassengerNoShow',
    'PassengerUnreachable',
  ];

  String _selectedReason = _reasons.first;
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  String _reasonLabel(String reason) => switch (reason) {
    'PassengerLate' => AppStrings.passengerLateReason,
    'PassengerNoShow' => AppStrings.passengerNoShowReason,
    'PassengerUnreachable' => AppStrings.passengerUnreachableReason,
    _ => reason,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.passengerLateNoShowTitle,
          textAlign: TextAlign.start,
          style: AppTextStyles.s20w700.copyWith(color: context.onSurface),
        ),
        AppSpacing.xs.verticalSpace,
        Text(
          AppStrings.cancelReasonLabel,
          style: AppTextStyles.s12w400.copyWith(
            color: context.onSurface.withValues(alpha: 0.60),
          ),
        ),
        AppSpacing.lg.verticalSpace,
        for (int i = 0; i < _reasons.length; i++) ...[
          if (i != 0) AppSpacing.sm.verticalSpace,
          TripCancelReasonRowWidget(
            label: _reasonLabel(_reasons[i]),
            isSelected: _selectedReason == _reasons[i],
            onTap: () => setState(() => _selectedReason = _reasons[i]),
          ),
        ],
        AppSpacing.lg.verticalSpace,
        TextField(
          controller: _noteController,
          maxLines: 2,
          style: AppTextStyles.s14w400.copyWith(color: context.onSurface),
          decoration: InputDecoration(
            hintText: AppStrings.cancelNoteHint,
            hintStyle: AppTextStyles.s14w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.45),
            ),
            filled: true,
            fillColor: context.onSurface.withValues(alpha: 0.03),
            contentPadding: REdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.sm.r),
              borderSide: BorderSide(
                color: context.onSurface.withValues(alpha: 0.10),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.sm.r),
              borderSide: BorderSide(
                color: context.onSurface.withValues(alpha: 0.10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.sm.r),
              borderSide: BorderSide(color: context.primary, width: 1.5),
            ),
          ),
        ),
        AppSpacing.md.verticalSpace,
        Text(
          AppStrings.cancelNoShowPolicyNote,
          textAlign: TextAlign.start,
          style: AppTextStyles.s12w400.copyWith(
            color: context.onSurface.withValues(alpha: 0.55),
          ),
        ),
        AppSpacing.lg.verticalSpace,
        Row(
          children: [
            Expanded(
              child: AppButton.outline(
                layout: const AppButtonLayout(height: 44),
                onTap: () => Navigator.of(context).pop(),
                child: AppButtonChild.label(AppStrings.cancel),
              ),
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: AppButton.variant(
                variant: AppButtonVariant.error,
                fill: AppButtonFill.solid,
                layout: const AppButtonLayout(height: 44),
                onTap: _confirm,
                child: AppButtonChild.label(AppStrings.cancelConfirmButton),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _confirm() {
    final note = _noteController.text.trim();
    context.read<TripBloc>().add(
      TripEvent.driverCancelRequested(
        tripId: widget.tripId,
        reason: _selectedReason,
        note: note.isEmpty ? null : note,
      ),
    );
    Navigator.of(context).pop();
  }
}
