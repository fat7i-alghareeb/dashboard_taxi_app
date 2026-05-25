import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/services/session/auth_manager.dart';
import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../constants/forms/kyc_forms.dart';
import '../../domain/entities/kyc_document_entity.dart';
import '../../domain/facade/kyc_facade.dart';

part 'kyc_event.dart';
part 'kyc_state.dart';
part 'kyc_bloc.freezed.dart';

@injectable
class KycBloc extends Bloc<KycEvent, KycState> {
  KycBloc(
    this._facade,
    this._authManager,
  ) : super(KycState(form: KycForms.formGroup())) {
    on<_Started>(_onStarted);
    on<_UploadDocumentRequested>(_onUploadDocumentRequested);
    on<_RefreshStatusRequested>(_onRefreshStatusRequested);
  }

  final KycFacade _facade;
  final AuthManager _authManager;

  Future<void> _onStarted(_Started event, Emitter<KycState> emit) async {
    emit(state.copyWith(
      driverId: event.driverId,
      fetchState: const BlocStatus.loading(),
    ));

    final result = await _facade.getDriverDocuments(event.driverId);
    result.when(
      success: (docs) {
        // Pre-fill existing uploaded document URLs inside reactive forms
        for (final doc in docs) {
          final controlKey = _getControlKey(doc.type);
          if (controlKey != null && doc.status != 'Rejected') {
            state.form.control(controlKey).value = doc.fileUrl;
          }
        }
        emit(state.copyWith(fetchState: BlocStatus.success(docs)));
      },
      failure: (message) => emit(state.copyWith(fetchState: BlocStatus.failure(message))),
    );
  }

  Future<void> _onUploadDocumentRequested(
    _UploadDocumentRequested event,
    Emitter<KycState> emit,
  ) async {
    emit(state.copyWith(
      uploadingType: event.type,
      uploadState: const BlocStatus.loading(),
    ));

    final result = await _facade.uploadDocument(
      driverId: state.driverId,
      type: event.type,
      filePath: event.filePath,
    );

    await result.when(
      success: (fileUrl) async {
        final controlKey = _getControlKey(event.type);
        if (controlKey != null) {
          state.form.control(controlKey).value = fileUrl;
          state.form.control(controlKey).markAsTouched();
        }
        emit(state.copyWith(uploadState: BlocStatus.success(fileUrl)));

        // Automatically trigger status check and reload the list of uploaded docs
        add(KycEvent.started(state.driverId));
        
        // Quietly refresh profile to see if status advanced on server side
        try {
          await _authManager.refreshCurrentUserProfile();
        } catch (_) {}
      },
      failure: (message) {
        emit(state.copyWith(uploadState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onRefreshStatusRequested(
    _RefreshStatusRequested event,
    Emitter<KycState> emit,
  ) async {
    emit(state.copyWith(refreshState: const BlocStatus.loading()));
    try {
      await _authManager.refreshCurrentUserProfile();
      emit(state.copyWith(refreshState: const BlocStatus.success(null)));
    } catch (e) {
      emit(state.copyWith(refreshState: BlocStatus.failure(e.toString())));
    }
  }

  String? _getControlKey(String docType) {
    switch (docType) {
      case 'DriversLicense':
        return KycForms.licenseField;
      case 'NationalId':
        return KycForms.idField;
      case 'VehicleRegistration':
        return KycForms.registrationField;
      case 'Insurance':
        return KycForms.insuranceField;
      default:
        return null;
    }
  }
}
