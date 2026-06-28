import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/error/global_error_handler.dart';
import '../../data/datasources/recordings_remote_datasource.dart';
import '../../domain/entities/trip_recording_entity.dart';

class RecordingsState {
  const RecordingsState({
    this.listState = const BlocStatus<List<TripRecordingEntity>>.initial(),
    this.search = '',
    this.passengerId,
    this.passengerName,
    this.page = 1,
    this.hasMore = true,
    this.loadingMore = false,
  });

  final BlocStatus<List<TripRecordingEntity>> listState;
  final String search;
  final String? passengerId;
  final String? passengerName;
  final int page;
  final bool hasMore;
  final bool loadingMore;

  bool get hasCustomerFilter =>
      passengerId != null && passengerId!.isNotEmpty;

  static const Object _unset = Object();

  RecordingsState copyWith({
    BlocStatus<List<TripRecordingEntity>>? listState,
    String? search,
    Object? passengerId = _unset,
    Object? passengerName = _unset,
    int? page,
    bool? hasMore,
    bool? loadingMore,
  }) {
    return RecordingsState(
      listState: listState ?? this.listState,
      search: search ?? this.search,
      passengerId:
          passengerId == _unset ? this.passengerId : passengerId as String?,
      passengerName: passengerName == _unset
          ? this.passengerName
          : passengerName as String?,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
    );
  }
}

@injectable
class RecordingsCubit extends Cubit<RecordingsState> {
  RecordingsCubit(this._dataSource) : super(const RecordingsState());

  final RecordingsRemoteDataSource _dataSource;
  Timer? _searchDebounce;

  static const int _pageSize = 20;

  Future<void> load() async {
    emit(
      state.copyWith(
        listState: const BlocStatus.loading(),
        page: 1,
        hasMore: true,
        loadingMore: false,
      ),
    );
    final search = state.search.trim();
    final result = await runAsResult(() async {
      final models = await _dataSource.getAllRecordings(
        pageSize: _pageSize,
        passengerId: state.passengerId,
        search: search.isEmpty ? null : search,
      );
      return models.map((m) => m.toEntity).toList();
    });
    result.when(
      success: (items) => emit(
        state.copyWith(
          listState: BlocStatus.success(items),
          page: 1,
          hasMore: items.length >= _pageSize,
        ),
      ),
      failure: (msg) =>
          emit(state.copyWith(listState: BlocStatus.failure(msg))),
    );
  }

  Future<void> nextPage() async {
    if (!state.hasMore || state.loadingMore) return;
    final current = state.listState.getDataWhenSuccess;
    if (current == null) return;
    final nextPage = state.page + 1;
    emit(state.copyWith(loadingMore: true));
    final search = state.search.trim();
    final result = await runAsResult(() async {
      final models = await _dataSource.getAllRecordings(
        page: nextPage,
        pageSize: _pageSize,
        passengerId: state.passengerId,
        search: search.isEmpty ? null : search,
      );
      return models.map((m) => m.toEntity).toList();
    });
    result.when(
      success: (items) {
        final merged = <TripRecordingEntity>[...current, ...items];
        emit(
          state.copyWith(
            listState: BlocStatus.success(merged),
            page: nextPage,
            hasMore: items.length >= _pageSize,
            loadingMore: false,
          ),
        );
      },
      failure: (_) => emit(state.copyWith(loadingMore: false)),
    );
  }

  void setSearch(String value) {
    emit(state.copyWith(search: value));
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (isClosed) return;
      load();
    });
  }

  void setCustomer(String? passengerId, String? name) {
    emit(state.copyWith(passengerId: passengerId, passengerName: name));
    load();
  }

  void clearCustomer() {
    emit(state.copyWith(passengerId: null, passengerName: null));
    load();
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
