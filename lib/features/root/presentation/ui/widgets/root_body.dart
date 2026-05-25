import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/domain/user_entity.dart';
import 'package:dashboardtaxi/core/services/session/auth_manager.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_body.dart';
import 'package:dashboardtaxi/features/driver_home/presentation/ui/widgets/driver_home_body.dart';
import 'package:dashboardtaxi/features/root/domain/services/root_mode_service.dart';
import 'package:dashboardtaxi/features/root/presentation/ui/widgets/root_mode_switch_widget.dart';

class RootBody extends StatefulWidget {
  const RootBody({super.key});

  @override
  State<RootBody> createState() => _RootBodyState();
}

class _RootBodyState extends State<RootBody> {
  late final RootModeService _modeService;

  @override
  void initState() {
    super.initState();
    _modeService = getIt<RootModeService>();
  }

  @override
  Widget build(BuildContext context) {
    final user = getIt<AuthManager>().currentUser;
    final isAdmin = _hasRole(user, 'Admin');
    final isDriver = _hasRole(user, 'Driver');
    final canSwitchMode = isAdmin && isDriver;

    if (!isAdmin && isDriver) {
      return const DriverHomeBody();
    }

    return ListenableBuilder(
      listenable: _modeService,
      builder: (context, child) {
        final isDriverMode = canSwitchMode && _modeService.isDriverMode;

        return Stack(
          children: [
            if (isDriverMode) const DriverHomeBody() else const DashboardBody(),
            if (canSwitchMode)
              RootModeSwitchWidget(
                isDriverMode: isDriverMode,
                onTap: _modeService.toggle,
              ),
          ],
        );
      },
    );
  }

  bool _hasRole(UserEntity? user, String role) {
    return user?.role == role || (user?.roles?.contains(role) ?? false);
  }
}
