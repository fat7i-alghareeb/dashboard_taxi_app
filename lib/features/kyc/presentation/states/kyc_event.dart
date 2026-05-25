part of 'kyc_bloc.dart';

@freezed
class KycEvent with _$KycEvent {
  const factory KycEvent.started(String driverId) = _Started;
  const factory KycEvent.uploadDocumentRequested({
    required String type,
    required String filePath,
  }) = _UploadDocumentRequested;
  const factory KycEvent.refreshStatusRequested() = _RefreshStatusRequested;
}
