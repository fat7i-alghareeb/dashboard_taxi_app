import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_scaffold/app_scaffold.dart';
import '../widgets/driver_body.dart';

class DriverScreen extends StatelessWidget {
  const DriverScreen({super.key});

  static const String pagePath = '/driver_screen';
  static const String pageName = 'DriverScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(child: const DriverBody());
  }
}
