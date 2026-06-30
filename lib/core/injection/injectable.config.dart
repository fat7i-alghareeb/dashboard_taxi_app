// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
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
import 'package:dashboardtaxi/core/services/location/driver_location_streamer.dart'
    as _i650;
import 'package:dashboardtaxi/core/services/location/location_service.dart'
    as _i113;
import 'package:dashboardtaxi/core/services/location/startup_map_warmup_coordinator.dart'
    as _i190;
import 'package:dashboardtaxi/core/services/maps/map_directions_service.dart'
    as _i247;
import 'package:dashboardtaxi/core/services/media/audio_playback_service.dart'
    as _i177;
import 'package:dashboardtaxi/core/services/onboarding/onboarding_service.dart'
    as _i565;
import 'package:dashboardtaxi/core/services/permissions/location_permission_service.dart'
    as _i88;
import 'package:dashboardtaxi/core/services/permissions/permissions_coordinator.dart'
    as _i403;
import 'package:dashboardtaxi/core/services/realtime/realtime_lifecycle_coordinator.dart'
    as _i1066;
import 'package:dashboardtaxi/core/services/realtime/realtime_service.dart'
    as _i868;
import 'package:dashboardtaxi/core/services/realtime/signalr_realtime_service.dart'
    as _i562;
import 'package:dashboardtaxi/core/services/session/auth_manager.dart'
    as _i322;
import 'package:dashboardtaxi/core/services/session/auth_state_notifier.dart'
    as _i1021;
import 'package:dashboardtaxi/core/services/session/jwt_token_storage.dart'
    as _i1043;
import 'package:dashboardtaxi/core/services/storage/storage_service.dart'
    as _i76;
import 'package:dashboardtaxi/core/theme/theme_controller.dart' as _i548;
import 'package:dashboardtaxi/features/admin_management/data/datasources/admin_management_remote_datasource.dart'
    as _i193;
import 'package:dashboardtaxi/features/admin_management/data/repositories/admin_management_repository_impl.dart'
    as _i127;
import 'package:dashboardtaxi/features/admin_management/domain/facade/admin_management_facade.dart'
    as _i625;
import 'package:dashboardtaxi/features/admin_management/domain/repositories/admin_management_repository.dart'
    as _i392;
import 'package:dashboardtaxi/features/auth/data/datasources/auth_firebase_datasource.dart'
    as _i538;
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
import 'package:dashboardtaxi/features/chat/data/datasources/chat_remote_datasource.dart'
    as _i770;
import 'package:dashboardtaxi/features/chat/data/repositories/chat_repository_impl.dart'
    as _i496;
import 'package:dashboardtaxi/features/chat/domain/repositories/chat_repository.dart'
    as _i832;
import 'package:dashboardtaxi/features/chat/presentation/states/chat_bloc.dart'
    as _i639;
import 'package:dashboardtaxi/features/company_contact/data/datasources/company_contact_remote_datasource.dart'
    as _i37;
import 'package:dashboardtaxi/features/company_contact/data/repositories/company_contact_repository_impl.dart'
    as _i888;
import 'package:dashboardtaxi/features/company_contact/domain/facade/company_contact_facade.dart'
    as _i132;
import 'package:dashboardtaxi/features/company_contact/domain/repositories/company_contact_repository.dart'
    as _i991;
import 'package:dashboardtaxi/features/company_contact/presentation/states/company_contact_bloc.dart'
    as _i211;
import 'package:dashboardtaxi/features/compensation/data/datasources/compensation_remote_datasource.dart'
    as _i756;
import 'package:dashboardtaxi/features/compensation/presentation/states/compensation_cubit.dart'
    as _i498;
import 'package:dashboardtaxi/features/customer_incidents/data/datasources/customer_incidents_remote_datasource.dart'
    as _i1043;
import 'package:dashboardtaxi/features/customer_incidents/presentation/states/customer_incident_detail_cubit.dart'
    as _i143;
import 'package:dashboardtaxi/features/customer_incidents/presentation/states/customer_incidents_cubit.dart'
    as _i907;
import 'package:dashboardtaxi/features/customers/data/datasources/customers_remote_datasource.dart'
    as _i674;
import 'package:dashboardtaxi/features/customers/presentation/states/customers_cubit.dart'
    as _i31;
import 'package:dashboardtaxi/features/dashboard/data/datasources/dashboard_remote_datasource.dart'
    as _i505;
import 'package:dashboardtaxi/features/dashboard/data/repositories/dashboard_repository_impl.dart'
    as _i150;
import 'package:dashboardtaxi/features/dashboard/domain/facade/dashboard_facade.dart'
    as _i969;
import 'package:dashboardtaxi/features/dashboard/domain/repositories/dashboard_repository.dart'
    as _i574;
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart'
    as _i508;
import 'package:dashboardtaxi/features/driver/data/datasources/driver_remote_datasource.dart'
    as _i506;
import 'package:dashboardtaxi/features/driver/data/repositories/driver_repository_impl.dart'
    as _i11;
import 'package:dashboardtaxi/features/driver/domain/facade/driver_facade.dart'
    as _i461;
import 'package:dashboardtaxi/features/driver/domain/repositories/driver_repository.dart'
    as _i336;
import 'package:dashboardtaxi/features/driver/presentation/states/driver_bloc.dart'
    as _i698;
import 'package:dashboardtaxi/features/driver_home/presentation/states/driver_home_bloc.dart'
    as _i170;
import 'package:dashboardtaxi/features/kyc/data/datasources/kyc_remote_datasource.dart'
    as _i221;
import 'package:dashboardtaxi/features/kyc/data/repositories/kyc_repository_impl.dart'
    as _i220;
import 'package:dashboardtaxi/features/kyc/domain/facade/kyc_facade.dart'
    as _i724;
import 'package:dashboardtaxi/features/kyc/domain/repositories/kyc_repository.dart'
    as _i986;
import 'package:dashboardtaxi/features/kyc/presentation/states/kyc_bloc.dart'
    as _i141;
import 'package:dashboardtaxi/features/notifications/data/datasources/notification_remote_datasource.dart'
    as _i6;
import 'package:dashboardtaxi/features/notifications/data/repositories/notification_repository_impl.dart'
    as _i39;
import 'package:dashboardtaxi/features/notifications/domain/facade/notification_facade.dart'
    as _i973;
import 'package:dashboardtaxi/features/notifications/domain/repositories/notification_repository.dart'
    as _i248;
import 'package:dashboardtaxi/features/profile/data/datasources/profile_remote_datasource.dart'
    as _i508;
import 'package:dashboardtaxi/features/profile/data/repositories/profile_repository_impl.dart'
    as _i309;
import 'package:dashboardtaxi/features/profile/domain/facade/profile_facade.dart'
    as _i512;
import 'package:dashboardtaxi/features/profile/domain/repositories/profile_repository.dart'
    as _i670;
import 'package:dashboardtaxi/features/profile/presentation/states/profile_bloc.dart'
    as _i356;
import 'package:dashboardtaxi/features/recordings/data/datasources/recordings_remote_datasource.dart'
    as _i422;
import 'package:dashboardtaxi/features/recordings/presentation/states/recordings_cubit.dart'
    as _i849;
import 'package:dashboardtaxi/features/refunds/data/datasources/refunds_remote_datasource.dart'
    as _i565;
import 'package:dashboardtaxi/features/refunds/data/repositories/refunds_repository_impl.dart'
    as _i253;
import 'package:dashboardtaxi/features/refunds/domain/facade/refunds_facade.dart'
    as _i239;
import 'package:dashboardtaxi/features/refunds/domain/repositories/refunds_repository.dart'
    as _i555;
import 'package:dashboardtaxi/features/refunds/presentation/states/refunds_cubit.dart'
    as _i323;
import 'package:dashboardtaxi/features/root/data/datasources/root_remote_datasource.dart'
    as _i1064;
import 'package:dashboardtaxi/features/root/data/repositories/root_repository_impl.dart'
    as _i349;
import 'package:dashboardtaxi/features/root/domain/facade/root_facade.dart'
    as _i397;
import 'package:dashboardtaxi/features/root/domain/repositories/root_repository.dart'
    as _i825;
import 'package:dashboardtaxi/features/root/domain/services/root_mode_service.dart'
    as _i885;
import 'package:dashboardtaxi/features/root/domain/services/root_tab_controller.dart'
    as _i452;
import 'package:dashboardtaxi/features/root/presentation/states/root_bloc.dart'
    as _i554;
import 'package:dashboardtaxi/features/support_contact/data/datasources/support_contact_remote_datasource.dart'
    as _i175;
import 'package:dashboardtaxi/features/support_contact/data/repositories/support_contact_repository_impl.dart'
    as _i215;
import 'package:dashboardtaxi/features/support_contact/domain/facade/support_contact_facade.dart'
    as _i733;
import 'package:dashboardtaxi/features/support_contact/domain/repositories/support_contact_repository.dart'
    as _i355;
import 'package:dashboardtaxi/features/support_contact/presentation/states/support_contact_bloc.dart'
    as _i188;
import 'package:dashboardtaxi/features/trip/data/datasources/trip_remote_datasource.dart'
    as _i642;
import 'package:dashboardtaxi/features/trip/data/repositories/trip_repository_impl.dart'
    as _i10;
import 'package:dashboardtaxi/features/trip/domain/facade/trip_facade.dart'
    as _i931;
import 'package:dashboardtaxi/features/trip/domain/repositories/trip_repository.dart'
    as _i217;
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart'
    as _i540;

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
    gh.singleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.singleton<_i892.FirebaseMessaging>(
      () => registerModule.firebaseMessaging,
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
    gh.lazySingleton<_i113.LocationService>(
      () => const _i113.LocationService(),
    );
    gh.lazySingleton<_i190.StartupMapWarmupCoordinator>(
      () => _i190.StartupMapWarmupCoordinator(),
    );
    gh.lazySingleton<_i177.AudioPlaybackService>(
      () => _i177.AudioPlaybackService(),
    );
    gh.lazySingleton<_i88.LocationPermissionService>(
      () => const _i88.LocationPermissionService(),
    );
    gh.lazySingleton<_i1021.AuthStateNotifier>(
      () => _i1021.AuthStateNotifier(),
    );
    gh.lazySingleton<_i885.RootModeService>(() => _i885.RootModeService());
    gh.lazySingleton<_i452.RootTabController>(() => _i452.RootTabController());
    gh.lazySingleton<_i538.AuthFirebaseDataSource>(
      () => _i538.AuthFirebaseDataSource(
        gh<_i59.FirebaseAuth>(),
        gh<_i892.FirebaseMessaging>(),
      ),
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
    gh.lazySingleton<_i403.PermissionsCoordinator>(
      () => _i403.PermissionsCoordinator(
        gh<_i17.NotificationCoordinator>(),
        gh<_i88.LocationPermissionService>(),
        gh<_i113.LocationService>(),
      ),
    );
    gh.factory<_i554.RootBloc>(
      () => _i554.RootBloc(
        gh<_i403.PermissionsCoordinator>(),
        gh<_i113.LocationService>(),
      ),
    );
    gh.lazySingleton<_i868.RealtimeService>(
      () => _i562.SignalRRealtimeService(gh<_i1043.JwtTokenStorage>()),
    );
    gh.lazySingleton<_i322.AuthManager>(
      () => _i322.AuthManager(
        storage: gh<_i76.StorageService>(),
        state: gh<_i1021.AuthStateNotifier>(),
        tokenStorage: gh<_i1043.JwtTokenStorage>(),
      ),
    );
    gh.lazySingleton<_i1066.RealtimeLifecycleCoordinator>(
      () => _i1066.RealtimeLifecycleCoordinator(
        gh<_i868.RealtimeService>(),
        gh<_i322.AuthManager>(),
      ),
    );
    gh.lazySingleton<_i758.LocalizationInterceptor>(
      () => _i758.LocalizationInterceptor(gh<_i1039.LocaleService>()),
    );
    gh.lazySingleton<_i328.AppRouterConfig>(
      () => _i328.AppRouterConfig(
        gh<_i1021.AuthStateNotifier>(),
        gh<_i403.PermissionsCoordinator>(),
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
    gh.lazySingleton<_i247.MapDirectionsService>(
      () => _i247.MapDirectionsService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i193.AdminManagementRemoteDataSource>(
      () => _i193.AdminManagementRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1012.AuthRemoteDataSource>(
      () => _i1012.AuthRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i770.ChatRemoteDataSource>(
      () => _i770.ChatRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i37.CompanyContactRemoteDataSource>(
      () => _i37.CompanyContactRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i756.CompensationRemoteDataSource>(
      () => _i756.CompensationRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1043.CustomerIncidentsRemoteDataSource>(
      () => _i1043.CustomerIncidentsRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i674.CustomersRemoteDataSource>(
      () => _i674.CustomersRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i505.DashboardRemoteDataSource>(
      () => _i505.DashboardRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i506.DriverRemoteDataSource>(
      () => _i506.DriverRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i221.KycRemoteDataSource>(
      () => _i221.KycRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i6.NotificationRemoteDataSource>(
      () => _i6.NotificationRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i508.ProfileRemoteDataSource>(
      () => _i508.ProfileRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i422.RecordingsRemoteDataSource>(
      () => _i422.RecordingsRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i565.RefundsRemoteDataSource>(
      () => _i565.RefundsRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1064.RootRemoteDataSource>(
      () => _i1064.RootRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i175.SupportContactRemoteDataSource>(
      () => _i175.SupportContactRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i642.TripRemoteDataSource>(
      () => _i642.TripRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i670.ProfileRepository>(
      () => _i309.ProfileRepositoryImpl(gh<_i508.ProfileRemoteDataSource>()),
    );
    gh.lazySingleton<_i512.ProfileFacade>(
      () => _i512.ProfileFacade(gh<_i670.ProfileRepository>()),
    );
    gh.lazySingleton<_i355.SupportContactRepository>(
      () => _i215.SupportContactRepositoryImpl(
        gh<_i175.SupportContactRemoteDataSource>(),
      ),
    );
    gh.factory<_i31.CustomersCubit>(
      () => _i31.CustomersCubit(gh<_i674.CustomersRemoteDataSource>()),
    );
    gh.factory<_i498.CompensationCubit>(
      () => _i498.CompensationCubit(gh<_i756.CompensationRemoteDataSource>()),
    );
    gh.factory<_i143.CustomerIncidentDetailCubit>(
      () => _i143.CustomerIncidentDetailCubit(
        gh<_i1043.CustomerIncidentsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i574.DashboardRepository>(
      () =>
          _i150.DashboardRepositoryImpl(gh<_i505.DashboardRemoteDataSource>()),
    );
    gh.lazySingleton<_i825.RootRepository>(
      () => _i349.RootRepositoryImpl(gh<_i1064.RootRemoteDataSource>()),
    );
    gh.lazySingleton<_i248.NotificationRepository>(
      () => _i39.NotificationRepositoryImpl(
        gh<_i6.NotificationRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i973.NotificationFacade>(
      () => _i973.NotificationFacade(gh<_i248.NotificationRepository>()),
    );
    gh.lazySingleton<_i832.ChatRepository>(
      () => _i496.ChatRepositoryImpl(gh<_i770.ChatRemoteDataSource>()),
    );
    gh.factory<_i639.ChatBloc>(
      () => _i639.ChatBloc(
        gh<_i832.ChatRepository>(),
        gh<_i868.RealtimeService>(),
        gh<_i322.AuthManager>(),
      ),
    );
    gh.lazySingleton<_i706.AuthRepository>(
      () => _i174.AuthRepositoryImpl(
        gh<_i538.AuthFirebaseDataSource>(),
        gh<_i1012.AuthRemoteDataSource>(),
        gh<_i322.AuthManager>(),
      ),
    );
    gh.lazySingleton<_i555.RefundsRepository>(
      () => _i253.RefundsRepositoryImpl(gh<_i565.RefundsRemoteDataSource>()),
    );
    gh.lazySingleton<_i733.SupportContactFacade>(
      () => _i733.SupportContactFacade(gh<_i355.SupportContactRepository>()),
    );
    gh.lazySingleton<_i392.AdminManagementRepository>(
      () => _i127.AdminManagementRepositoryImpl(
        gh<_i193.AdminManagementRemoteDataSource>(),
      ),
    );
    gh.factory<_i188.SupportContactBloc>(
      () => _i188.SupportContactBloc(gh<_i733.SupportContactFacade>()),
    );
    gh.lazySingleton<_i991.CompanyContactRepository>(
      () => _i888.CompanyContactRepositoryImpl(
        gh<_i37.CompanyContactRemoteDataSource>(),
      ),
    );
    gh.factory<_i849.RecordingsCubit>(
      () => _i849.RecordingsCubit(gh<_i422.RecordingsRemoteDataSource>()),
    );
    gh.factory<_i356.ProfileBloc>(
      () => _i356.ProfileBloc(gh<_i512.ProfileFacade>()),
    );
    gh.lazySingleton<_i471.AuthFacade>(
      () => _i471.AuthFacade(gh<_i706.AuthRepository>()),
    );
    gh.lazySingleton<_i397.RootFacade>(
      () => _i397.RootFacade(gh<_i825.RootRepository>()),
    );
    gh.lazySingleton<_i986.KycRepository>(
      () => _i220.KycRepositoryImpl(gh<_i221.KycRemoteDataSource>()),
    );
    gh.lazySingleton<_i724.KycFacade>(
      () => _i724.KycFacade(gh<_i986.KycRepository>()),
    );
    gh.factory<_i907.CustomerIncidentsCubit>(
      () => _i907.CustomerIncidentsCubit(
        gh<_i1043.CustomerIncidentsRemoteDataSource>(),
        gh<_i868.RealtimeService>(),
      ),
    );
    gh.lazySingleton<_i336.DriverRepository>(
      () => _i11.DriverRepositoryImpl(gh<_i506.DriverRemoteDataSource>()),
    );
    gh.lazySingleton<_i217.TripRepository>(
      () => _i10.TripRepositoryImpl(gh<_i642.TripRemoteDataSource>()),
    );
    gh.lazySingleton<_i969.DashboardFacade>(
      () => _i969.DashboardFacade(gh<_i574.DashboardRepository>()),
    );
    gh.lazySingleton<_i239.RefundsFacade>(
      () => _i239.RefundsFacade(gh<_i555.RefundsRepository>()),
    );
    gh.lazySingleton<_i132.CompanyContactFacade>(
      () => _i132.CompanyContactFacade(gh<_i991.CompanyContactRepository>()),
    );
    gh.lazySingleton<_i625.AdminManagementFacade>(
      () => _i625.AdminManagementFacade(gh<_i392.AdminManagementRepository>()),
    );
    gh.factory<_i100.AuthBloc>(() => _i100.AuthBloc(gh<_i471.AuthFacade>()));
    gh.lazySingleton<_i461.DriverFacade>(
      () => _i461.DriverFacade(gh<_i336.DriverRepository>()),
    );
    gh.factory<_i141.KycBloc>(
      () => _i141.KycBloc(gh<_i724.KycFacade>(), gh<_i322.AuthManager>()),
    );
    gh.lazySingleton<_i931.TripFacade>(
      () => _i931.TripFacade(gh<_i217.TripRepository>()),
    );
    gh.factory<_i508.DashboardBloc>(
      () => _i508.DashboardBloc(
        gh<_i969.DashboardFacade>(),
        gh<_i868.RealtimeService>(),
        gh<_i885.RootModeService>(),
      ),
    );
    gh.factory<_i323.RefundsCubit>(
      () => _i323.RefundsCubit(
        gh<_i239.RefundsFacade>(),
        gh<_i868.RealtimeService>(),
      ),
    );
    gh.factory<_i211.CompanyContactBloc>(
      () => _i211.CompanyContactBloc(gh<_i132.CompanyContactFacade>()),
    );
    gh.lazySingleton<_i650.DriverLocationStreamer>(
      () => _i650.DriverLocationStreamer(
        gh<_i113.LocationService>(),
        gh<_i1043.JwtTokenStorage>(),
        gh<_i461.DriverFacade>(),
      ),
    );
    gh.factory<_i698.DriverBloc>(
      () => _i698.DriverBloc(gh<_i461.DriverFacade>()),
    );
    gh.factory<_i170.DriverHomeBloc>(
      () => _i170.DriverHomeBloc(
        gh<_i461.DriverFacade>(),
        gh<_i650.DriverLocationStreamer>(),
        gh<_i868.RealtimeService>(),
        gh<_i322.AuthManager>(),
      ),
    );
    gh.lazySingleton<_i540.TripBloc>(
      () => _i540.TripBloc(
        gh<_i931.TripFacade>(),
        gh<_i868.RealtimeService>(),
        gh<_i322.AuthManager>(),
        gh<_i650.DriverLocationStreamer>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i959.RegisterModule {}
