part of 'kyc_bloc.dart';

@freezed
abstract class KycState with _$KycState {
  const factory KycState({
    @Default('') String driverId,
    @Default('') String uploadingType,
    @Default(BlocStatus<List<KycDocumentEntity>>.initial())
    BlocStatus<List<KycDocumentEntity>> fetchState,
    @Default(BlocStatus<String>.initial())
    BlocStatus<String> uploadState,
    @Default(BlocStatus<void>.initial())
    BlocStatus<void> refreshState,
    required FormGroup form,
  }) = _KycState;
}
