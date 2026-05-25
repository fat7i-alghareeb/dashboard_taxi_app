import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_scaffold/app_scaffold.dart';
import '../widgets/trip_body.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({super.key});

  static const String pagePath = '/trip_screen';
  static const String pageName = 'TripScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(child: const TripBody());
  }
}
