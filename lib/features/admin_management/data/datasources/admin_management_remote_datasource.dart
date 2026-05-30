import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../params/register_admin_params.dart';

@lazySingleton
class AdminManagementRemoteDataSource {
  const AdminManagementRemoteDataSource(this._dio);

  final Dio _dio;

  Future<String> registerAdmin(RegisterAdminParams params) {
    return rethrowAsAppException(() async {
      printY(
        '[AdminManagementRemoteDataSource] registerAdmin -> '
        '${ApiEndpoints.registerAdmin} userName="${params.userName}"',
      );
      final response = await _dio.post<dynamic>(
        ApiEndpoints.registerAdmin,
        data: params.toJson(),
      );
      final id = response.data?.toString() ?? '';
      printG('[AdminManagementRemoteDataSource] registerAdmin success id=$id');
      return id;
    });
  }
}
