import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_scaffold/app_scaffold.dart';
import '../widgets/dashboard_body.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const String pagePath = '/dashboard_screen';
  static const String pageName = 'DashboardScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(child: const DashboardBody());
  }
}
