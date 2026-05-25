import '../../domain/entities/kyc_entity.dart';
import '../models/kyc_model.dart';

extension KycModelMapper on KycModel {
  KycEntity get toEntity => KycEntity(id: id);
}
