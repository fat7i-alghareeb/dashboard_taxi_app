import 'package:injectable/injectable.dart';

import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../data/params/register_admin_params.dart';
import '../repositories/admin_management_repository.dart';

@lazySingleton
class AdminManagementFacade {
  const AdminManagementFacade(this._repository);

  final AdminManagementRepository _repository;

  Future<Result<String>> registerAdmin(RegisterAdminParams params) {
    printC(
      '[AdminManagementFacade] registerAdmin userName="${params.userName}"',
    );
    return _repository.registerAdmin(params);
  }
}
