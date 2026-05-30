import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/repositories/admin_management_repository.dart';
import '../datasources/admin_management_remote_datasource.dart';
import '../params/register_admin_params.dart';

@LazySingleton(as: AdminManagementRepository)
class AdminManagementRepositoryImpl implements AdminManagementRepository {
  const AdminManagementRepositoryImpl(this._remote);

  final AdminManagementRemoteDataSource _remote;

  @override
  Future<Result<String>> registerAdmin(RegisterAdminParams params) {
    return runAsResult(() async {
      printC(
        '[AdminManagementRepository] registerAdmin start '
        'userName="${params.userName}"',
      );
      final id = await _remote.registerAdmin(params);
      printG('[AdminManagementRepository] registerAdmin success id=$id');
      return id;
    });
  }
}
