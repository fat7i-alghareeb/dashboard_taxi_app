import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/entities/company_contact_entity.dart';
import '../../domain/facade/company_contact_facade.dart';

// ---------------------------------------------------------------------------
// Events
// ---------------------------------------------------------------------------

sealed class CompanyContactEvent {}

final class CompanyContactLoadRequested extends CompanyContactEvent {}

final class CompanyContactUpdateRequested extends CompanyContactEvent {
  CompanyContactUpdateRequested({
    required this.email,
    required this.phone,
    required this.website,
  });
  final String email;
  final String phone;
  final String website;
}

final class CompanyContactUpdateAcknowledged extends CompanyContactEvent {}

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class CompanyContactState {
  const CompanyContactState({
    this.loadStatus = const BlocStatus.initial(),
    this.updateStatus = const BlocStatus.initial(),
    this.contact,
  });

  final BlocStatus<CompanyContactEntity> loadStatus;
  final BlocStatus<void> updateStatus;
  final CompanyContactEntity? contact;

  CompanyContactState copyWith({
    BlocStatus<CompanyContactEntity>? loadStatus,
    BlocStatus<void>? updateStatus,
    CompanyContactEntity? contact,
  }) {
    return CompanyContactState(
      loadStatus: loadStatus ?? this.loadStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      contact: contact ?? this.contact,
    );
  }
}

// ---------------------------------------------------------------------------
// BLoC
// ---------------------------------------------------------------------------

@injectable
class CompanyContactBloc
    extends Bloc<CompanyContactEvent, CompanyContactState> {
  CompanyContactBloc(this._facade) : super(const CompanyContactState()) {
    on<CompanyContactLoadRequested>(_onLoadRequested);
    on<CompanyContactUpdateRequested>(_onUpdateRequested);
    on<CompanyContactUpdateAcknowledged>(_onUpdateAcknowledged);
  }

  final CompanyContactFacade _facade;

  Future<void> _onLoadRequested(
    CompanyContactLoadRequested event,
    Emitter<CompanyContactState> emit,
  ) async {
    printM('[CompanyContactBloc] load requested');
    emit(state.copyWith(loadStatus: const BlocStatus.loading()));

    final result = await _facade.getCompanyContact();

    result.when(
      success: (contact) {
        printG('[CompanyContactBloc] load success');
        emit(
          state.copyWith(
            loadStatus: BlocStatus.success(contact),
            contact: contact,
          ),
        );
      },
      failure: (message) {
        printY('[CompanyContactBloc] load failed: $message');
        emit(state.copyWith(loadStatus: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onUpdateRequested(
    CompanyContactUpdateRequested event,
    Emitter<CompanyContactState> emit,
  ) async {
    printM('[CompanyContactBloc] update requested');
    emit(state.copyWith(updateStatus: const BlocStatus.loading()));

    final result = await _facade.updateCompanyContact(
      email: event.email,
      phone: event.phone,
      website: event.website,
    );

    result.when(
      success: (contact) {
        printG('[CompanyContactBloc] update success');
        emit(
          state.copyWith(
            updateStatus: const BlocStatus.success(null),
            contact: contact,
          ),
        );
      },
      failure: (message) {
        printY('[CompanyContactBloc] update failed: $message');
        emit(state.copyWith(updateStatus: BlocStatus.failure(message)));
      },
    );
  }

  void _onUpdateAcknowledged(
    CompanyContactUpdateAcknowledged event,
    Emitter<CompanyContactState> emit,
  ) {
    emit(state.copyWith(updateStatus: const BlocStatus.initial()));
  }
}
