import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/domain/extensions/user_role_extensions.dart';
import 'package:dashboardtaxi/core/services/session/auth_manager.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';

/// Admin-only "Cancel trip" action. Cancels via the passenger/admin
/// cancellation endpoint (admin override → full refund per policy) for any
/// non-terminal, not-yet-in-progress trip.
class TripAdminCancelButton extends StatelessWidget {
  const TripAdminCancelButton({
    super.key,
    required this.tripId,
    required this.isLoading,
  });

  final String tripId;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    // Defense-in-depth: this admin-only action is also enforced server-side,
    // but never render it for non-admins.
    if (getIt<AuthManager>().currentUser?.isAdmin != true) {
      return const SizedBox.shrink();
    }

    return AppButton.outline(
      variant: AppButtonVariant.error,
      isLoading: isLoading,
      layout: const AppButtonLayout(height: 44),
      onTap: isLoading ? null : () => _confirm(context),
      child: AppButtonChild.labelIcon(
        label: 'Cancel trip',
        icon: IconSource.widget(
          FaIcon(FontAwesomeIcons.ban, size: 14.r),
          size: 14,
        ),
        textStyle: AppTextStyles.s14w500,
      ),
    );
  }

  Future<void> _confirm(BuildContext context) async {
    final bloc = context.read<TripBloc>();
    final confirm = await AppDialog.show<bool>(
      context,
      dialog: AppDialog.basic(
        title: 'Cancel trip',
        message:
            'Cancel this trip? The customer will be refunded per the '
            'cancellation policy.',
        secondaryAction: AppDialogAction.secondary(
          label: AppStrings.cancel,
          onPressed: () => Navigator.pop(context, false),
        ),
        primaryAction: AppDialogAction.danger(
          label: 'Cancel trip',
          onPressed: () => Navigator.pop(context, true),
        ),
      ),
    );

    if (confirm == true) {
      bloc.add(TripEvent.adminCancelRequested(tripId));
    }
  }
}
