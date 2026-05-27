import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../models/profile_model.dart';

@lazySingleton
class ProfileRemoteDataSource {
  const ProfileRemoteDataSource(this._dio);

  final Dio _dio;

  Future<ProfileModel> getAdminProfile() {
    return rethrowAsAppException(() async {
      printY('[ProfileRemoteDataSource] GET admin profile');
      final response = await _dio.get<dynamic>(ApiEndpoints.currentAdminProfile);
      return ProfileModel.fromAdminJson(
        Map<String, dynamic>.from(response.data as Map),
      );
    });
  }

  Future<ProfileModel> updateAdminProfile({
    required String name,
    required String email,
    String? phone1,
    String? phone2,
  }) {
    return rethrowAsAppException(() async {
      printY('[ProfileRemoteDataSource] PUT admin profile');
      final response = await _dio.put<dynamic>(
        ApiEndpoints.currentAdminProfile,
        data: {
          'name': name,
          'email': email,
          'phone1': phone1,
          'phone2': phone2,
        },
      );
      return ProfileModel.fromAdminJson(
        Map<String, dynamic>.from(response.data as Map),
      );
    });
  }

  Future<ProfileModel> getDriverProfile() {
    return rethrowAsAppException(() async {
      printY('[ProfileRemoteDataSource] GET driver profile');
      final response =
          await _dio.get<dynamic>(ApiEndpoints.currentDriverProfile);
      return ProfileModel.fromDriverJson(
        Map<String, dynamic>.from(response.data as Map),
      );
    });
  }

  Future<ProfileModel> updateDriverProfile({
    required String name,
    String? email,
  }) {
    return rethrowAsAppException(() async {
      printY('[ProfileRemoteDataSource] PUT driver profile');
      final response = await _dio.put<dynamic>(
        ApiEndpoints.currentDriverProfile,
        data: {'name': name, 'email': email},
      );
      return ProfileModel.fromDriverJson(
        Map<String, dynamic>.from(response.data as Map),
      );
    });
  }
}
