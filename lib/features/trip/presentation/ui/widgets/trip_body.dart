import 'package:dashboardtaxi/common/imports/imports.dart';

class TripBody extends StatelessWidget {
  const TripBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.tripNoActiveRide,
        style: AppTextStyles.s16w600.copyWith(color: context.onSurface),
      ),
    );
  }
}
