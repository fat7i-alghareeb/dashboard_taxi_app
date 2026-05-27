import 'package:dashboardtaxi/common/imports/imports.dart';

import 'root_map_recenter_button_widget.dart';

class RootMapControlsSection extends StatelessWidget {
  const RootMapControlsSection({
    super.key,
    required this.onRecenterTap,
  });

  final VoidCallback onRecenterTap;

  @override
  Widget build(BuildContext context) {
    return RootMapRecenterButtonWidget(onTap: onRecenterTap);
  }
}
