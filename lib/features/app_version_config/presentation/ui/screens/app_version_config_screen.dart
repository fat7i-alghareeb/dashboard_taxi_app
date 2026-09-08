import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/app_version_config/domain/entities/app_version_config_entity.dart';
import 'package:dashboardtaxi/features/app_version_config/presentation/states/app_version_config_bloc.dart';
import 'package:dashboardtaxi/features/app_version_config/presentation/ui/widgets/app_version_config_form.dart';

/// Admin-only screen controlling the customer app's remote version gate:
/// a master switch plus per-platform latest/minimum versions and store URLs.
class AppVersionConfigScreen extends StatelessWidget {
  const AppVersionConfigScreen({super.key});

  static const String pagePath = '/app-version';
  static const String pageName = 'AppVersionConfigScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<AppVersionConfigBloc>()..add(AppVersionConfigLoadRequested()),
      child: const _AppVersionConfigBody(),
    );
  }
}

class _AppVersionConfigBody extends StatelessWidget {
  const _AppVersionConfigBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppVersionConfigBloc, AppVersionConfigState>(
      listenWhen: (a, b) => a.updateStatus != b.updateStatus,
      listener: (context, state) {
        if (state.updateStatus.isSuccess) {
          showSuccessOverlay(
            context,
            AppStrings.appVersionConfigSavedSuccess,
          );
          context.read<AppVersionConfigBloc>().add(
            AppVersionConfigUpdateAcknowledged(),
          );
        } else if (state.updateStatus.isFailed) {
          showErrorOverlay(
            context,
            state.updateStatus.errorMessage ?? AppStrings.somethingWentWrong,
          );
          context.read<AppVersionConfigBloc>().add(
            AppVersionConfigUpdateAcknowledged(),
          );
        }
      },
      builder: (context, state) {
        return AppScaffold.appBar(
          appBarConfig: AppScaffoldAppBarConfig(
            title: AppStrings.appVersionConfigTitle,
            subtitle: AppStrings.appVersionConfigSubtitle,
          ),
          child: StatusBuilder<AppVersionConfigEntity>(
            state: state.loadStatus,
            errorMessage: AppStrings.appVersionConfigLoadFailed,
            onError: () => context.read<AppVersionConfigBloc>().add(
              AppVersionConfigLoadRequested(),
            ),
            success: (config) => AppVersionConfigForm(
              config: config,
              isSaving: state.updateStatus.isLoading,
            ),
          ),
        );
      },
    );
  }
}
