import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/services/realtime/realtime_event.dart';
import '../../../../core/services/realtime/realtime_service.dart';
import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../data/datasources/customer_incidents_remote_datasource.dart';
import '../../domain/entities/customer_incident_entity.dart';
import '../../domain/entities/incident_type.dart';

class CustomerIncidentsState {
  const CustomerIncidentsState({
    this.listState = const BlocStatus<List<CustomerIncidentEntity>>.initial(),
    this.selectedType,
    this.customerId,
    this.customerName,
  });

  final BlocStatus<List<CustomerIncidentEntity>> listState;

  /// null = "All types".
  final IncidentType? selectedType;
  final String? customerId;
  final String? customerName;

  bool get hasCustomerFilter => customerId != null && customerId!.isNotEmpty;

  static const Object _unset = Object();

  CustomerIncidentsState copyWith({
    BlocStatus<List<CustomerIncidentEntity>>? listState,
    Object? selectedType = _unset,
    Object? customerId = _unset,
    Object? customerName = _unset,
  }) {
    return CustomerIncidentsState(
      listState: listState ?? this.listState,
      selectedType: selectedType == _unset
          ? this.selectedType
          : selectedType as IncidentType?,
      customerId: customerId == _unset ? this.customerId : customerId as String?,
      customerName:
          customerName == _unset ? this.customerName : customerName as String?,
    );
  }
}

@injectable
class CustomerIncidentsCubit extends Cubit<CustomerIncidentsState> {
  CustomerIncidentsCubit(this._dataSource, this._realtime)
    : super(const CustomerIncidentsState()) {
    // Live-refresh the feed whenever a new incident is pushed to admins.
    _sub = _realtime.events.listen((event) {
      if (event is RealtimeCustomerIncidentRaised) {
        load();
      }
    });
  }

  final CustomerIncidentsRemoteDataSource _dataSource;
  final RealtimeService _realtime;
  StreamSubscription<RealtimeEvent>? _sub;

  Future<void> load() async {
    emit(state.copyWith(listState: const BlocStatus.loading()));
    final result = await runAsResult(() async {
      final models = await _dataSource.getIncidents(
        type: state.selectedType?.toJson(),
        passengerId: state.customerId,
      );
      return models.map((m) => m.toEntity).toList();
    });
    result.when(
      success: (items) =>
          emit(state.copyWith(listState: BlocStatus.success(items))),
      failure: (msg) =>
          emit(state.copyWith(listState: BlocStatus.failure(msg))),
    );
  }

  void setType(IncidentType? type) {
    emit(state.copyWith(selectedType: type));
    load();
  }

  void setCustomer(String passengerId, String? name) {
    emit(state.copyWith(customerId: passengerId, customerName: name));
    load();
  }

  void clearCustomer() {
    emit(state.copyWith(customerId: null, customerName: null));
    load();
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
