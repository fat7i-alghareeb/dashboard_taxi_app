import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../models/company_contact_model.dart';

@lazySingleton
class CompanyContactRemoteDataSource {
  const CompanyContactRemoteDataSource(this._dio);

  final Dio _dio;

  Future<CompanyContactModel> getCompanyContact() {
    return rethrowAsAppException(() async {
      printY('[CompanyContactRemoteDataSource] GET company contact');
      final response = await _dio.get<dynamic>(ApiEndpoints.companyContact);
      return CompanyContactModel.fromJson(
        Map<String, dynamic>.from(response.data as Map),
      );
    });
  }

  Future<CompanyContactModel> updateCompanyContact({
    required String email,
    required String phone,
    required String website,
  }) {
    return rethrowAsAppException(() async {
      printY('[CompanyContactRemoteDataSource] PUT company contact');
      final response = await _dio.put<dynamic>(
        ApiEndpoints.companyContact,
        data: {
          'email': email,
          'phone': phone,
          'website': website,
        },
      );
      return CompanyContactModel.fromJson(
        Map<String, dynamic>.from(response.data as Map),
      );
    });
  }
}
