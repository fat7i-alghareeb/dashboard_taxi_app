import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';

/// Shows a reason-selection dialog for driver cancellation (passenger no-show).
/// Dispatches [TripEvent.driverCancelRequested] on confirmation.
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
          style: AppTextStyles.s20w700.copyWith(color: context.onSurface),
          textAlign: TextAlign.center,
        ),
        AppSpacing.md.verticalSpace,
        Text(
          AppStrings.cancelReasonLabel,
          style: AppTextStyles.s14w400.copyWith(
            color: context.onSurface.withValues(alpha: 0.7),
          ),
        ),
        AppSpacing.xs.verticalSpace,
        ..._reasons.map(
          (reason) => InkWell(
            onTap: () => setState(() => _selectedReason = reason),
            borderRadius: BorderRadius.circular(6.r),
            child: Row(
              children: [
                Radio<String>(
                  value: reason,
                  groupValue: _selectedReason,
                  onChanged: (v) => setState(() => _selectedReason = v!),
                ),
                Expanded(
                  child: Text(
                    _reasonLabel(reason),
                    style: AppTextStyles.s14w400.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        AppSpacing.sm.verticalSpace,
        TextField(
          controller: _noteController,
          maxLines: 2,
          style: AppTextStyles.s14w400.copyWith(color: context.onSurface),
          decoration: InputDecoration(
            hintText: AppStrings.cancelNoteHint,
            hintStyle: AppTextStyles.s14w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.45),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        AppSpacing.md.verticalSpace,
        Text(
          AppStrings.cancelNoShowPolicyNote,
          style: AppTextStyles.s12w400.copyWith(
            color: context.onSurface.withValues(alpha: 0.55),
          ),
          textAlign: TextAlign.center,
        ),
        AppSpacing.lg.verticalSpace,
        AppButton.variant(
          variant: AppButtonVariant.error,
          fill: AppButtonFill.solid,
          onTap: _confirm,
          child: AppButtonChild.label(AppStrings.cancelConfirmButton),
        ),
        AppSpacing.sm.verticalSpace,
        AppButton.variant(
          variant: AppButtonVariant.grey,
          fill: AppButtonFill.solid,
          onTap: () => Navigator.of(context).pop(),
          child: AppButtonChild.label(AppStrings.cancel),
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
