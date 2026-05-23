// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:dashboardtaxi/core/injection/register_module.dart' as _i959;
import 'package:dashboardtaxi/core/network/interceptors/custom_dio_interceptor.dart'
    as _i1024;
import 'package:dashboardtaxi/core/network/interceptors/error_interceptor.dart'
    as _i784;
import 'package:dashboardtaxi/core/network/interceptors/localization_interceptor.dart'
    as _i758;
import 'package:dashboardtaxi/core/network/interceptors/memory_aware_interceptor.dart'
    as _i436;
import 'package:dashboardtaxi/core/notification/notification_coordinator.dart'
    as _i17;
import 'package:dashboardtaxi/core/notification/notification_fcm_service.dart'
    as _i282;
import 'package:dashboardtaxi/core/notification/notification_local_service.dart'
    as _i729;
import 'package:dashboardtaxi/core/notification/notification_permission_service.dart'
    as _i318;
import 'package:dashboardtaxi/core/notification/notification_timezone_service.dart'
    as _i1022;
import 'package:dashboardtaxi/core/router/router_config.dart' as _i328;
import 'package:dashboardtaxi/core/services/localization/locale_service.dart'
    as _i1039;
import 'package:dashboardtaxi/core/services/onboarding/onboarding_service.dart'
    as _i565;
import 'package:dashboardtaxi/core/services/session/auth_manager.dart'
    as _i322;
import 'package:dashboardtaxi/core/services/session/auth_state_notifier.dart'
    as _i1021;
import 'package:dashboardtaxi/core/services/session/jwt_token_storage.dart'
    as _i1043;
import 'package:dashboardtaxi/core/services/storage/storage_service.dart'
    as _i76;
import 'package:dashboardtaxi/core/theme/theme_controller.dart' as _i548;
import 'package:dashboardtaxi/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i1012;
import 'package:dashboardtaxi/features/auth/data/repositories/auth_repository_impl.dart'
    as _i174;
import 'package:dashboardtaxi/features/auth/domain/facade/auth_facade.dart'
    as _i471;
import 'package:dashboardtaxi/features/auth/domain/repositories/auth_repository.dart'
    as _i706;
import 'package:dashboardtaxi/features/auth/presentation/states/auth_bloc.dart'
    as _i100;
import 'package:dashboardtaxi/features/root/data/datasources/root_remote_datasource.dart'
    as _i1064;
import 'package:dashboardtaxi/features/root/data/repositories/root_repository_impl.dart'
    as _i349;
import 'package:dashboardtaxi/features/root/domain/facade/root_facade.dart'
    as _i397;
import 'package:dashboardtaxi/features/root/domain/repositories/root_repository.dart'
    as _i825;
import 'package:dashboardtaxi/features/root/presentation/states/root_bloc.dart'
    as _i554;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i76.StorageService>(
      () => registerModule.storageService,
      preResolve: true,
    );
    gh.lazySingleton<_i1024.CustomDioInterceptor>(
      () => _i1024.CustomDioInterceptor(),
    );
    gh.lazySingleton<_i784.ErrorInterceptor>(() => _i784.ErrorInterceptor());
    gh.lazySingleton<_i436.MemoryAwareInterceptor>(
      () => _i436.MemoryAwareInterceptor(),
    );
    gh.lazySingleton<_i282.NotificationFcmService>(
      () => _i282.NotificationFcmService(),
    );
    gh.lazySingleton<_i729.NotificationLocalService>(
      () => _i729.NotificationLocalService(),
    );
    gh.lazySingleton<_i318.NotificationPermissionService>(
      () => const _i318.NotificationPermissionService(),
    );
    gh.lazySingleton<_i1022.NotificationTimezoneService>(
      () => _i1022.NotificationTimezoneService(),
    );
    gh.lazySingleton<_i328.AppRouteRegistry>(
      () => const _i328.AppRouteRegistry(),
    );
    gh.lazySingleton<_i1021.AuthStateNotifier>(
      () => _i1021.AuthStateNotifier(),
    );
    gh.lazySingleton<_i1039.LocaleService>(
      () => _i1039.LocaleService(gh<_i76.StorageService>()),
    );
    gh.lazySingleton<_i565.OnboardingService>(
      () => _i565.OnboardingService(gh<_i76.StorageService>()),
    );
    gh.lazySingleton<_i1043.JwtTokenStorage>(
      () => _i1043.JwtTokenStorage(gh<_i76.StorageService>()),
    );
    gh.lazySingleton<_i548.ThemeController>(
      () => _i548.ThemeController(gh<_i76.StorageService>()),
    );
    gh.lazySingleton<_i17.NotificationCoordinator>(
      () => _i17.NotificationCoordinator(
        gh<_i318.NotificationPermissionService>(),
        gh<_i1022.NotificationTimezoneService>(),
        gh<_i729.NotificationLocalService>(),
        gh<_i282.NotificationFcmService>(),
      ),
    );
    gh.lazySingleton<_i322.AuthManager>(
      () => _i322.AuthManager(
        storage: gh<_i76.StorageService>(),
        state: gh<_i1021.AuthStateNotifier>(),
        tokenStorage: gh<_i1043.JwtTokenStorage>(),
      ),
    );
    gh.lazySingleton<_i758.LocalizationInterceptor>(
      () => _i758.LocalizationInterceptor(gh<_i1039.LocaleService>()),
    );
    gh.lazySingleton<_i328.AppRouterConfig>(
      () => _i328.AppRouterConfig(
        gh<_i1021.AuthStateNotifier>(),
        gh<_i565.OnboardingService>(),
        gh<_i328.AppRouteRegistry>(),
      ),
    );
    gh.singleton<_i361.Dio>(
      () => registerModule.dio(
        gh<_i436.MemoryAwareInterceptor>(),
        gh<_i758.LocalizationInterceptor>(),
        gh<_i784.ErrorInterceptor>(),
        gh<_i1024.CustomDioInterceptor>(),
        gh<_i322.AuthManager>(),
        gh<_i1043.JwtTokenStorage>(),
      ),
    );
    gh.lazySingleton<_i1012.AuthRemoteDataSource>(
      () => _i1012.AuthRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1064.RootRemoteDataSource>(
      () => _i1064.RootRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i825.RootRepository>(
      () => _i349.RootRepositoryImpl(gh<_i1064.RootRemoteDataSource>()),
    );
    gh.lazySingleton<_i706.AuthRepository>(
      () => _i174.AuthRepositoryImpl(gh<_i1012.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i471.AuthFacade>(
      () => _i471.AuthFacade(gh<_i706.AuthRepository>()),
    );
    gh.lazySingleton<_i397.RootFacade>(
      () => _i397.RootFacade(gh<_i825.RootRepository>()),
    );
    gh.factory<_i554.RootBloc>(() => _i554.RootBloc(gh<_i397.RootFacade>()));
    gh.factory<_i100.AuthBloc>(() => _i100.AuthBloc(gh<_i471.AuthFacade>()));
    return this;
  }
}

class _$RegisterModule extends _i959.RegisterModule {}
