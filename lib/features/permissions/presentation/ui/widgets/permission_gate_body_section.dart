import 'package:dashboardtaxi/common/imports/imports.dart';

import 'permission_gate_blocked_section.dart';
import 'permission_gate_loading_section.dart';
import 'permission_gate_ui_state.dart';

class PermissionGateBodySection extends StatelessWidget {
  const PermissionGateBodySection({
    super.key,
    required this.state,
    required this.onOpenSettings,
    required this.onRetry,
  });

  final PermissionGateUiState state;
  final Future<void> Function() onOpenSettings;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    if (state == PermissionGateUiState.loading) {
      return const PermissionGateLoadingSection();
    }

    return PermissionGateBlockedSection(
      state: state,
      onOpenSettings: onOpenSettings,
      onRetry: onRetry,
    );
  }
}
