import '../../domain/entities/kyc_document_entity.dart';
import '../models/kyc_document_model.dart';

extension KycDocumentModelMapper on KycDocumentModel {
  KycDocumentEntity toEntity(String driverId) {
    return KycDocumentEntity(
      id: id,
      driverId: driverId,
      type: type,
      fileUrl: fileUrl,
      status: status,
      reviewNotes: reviewNotes,
    );
  }
}
