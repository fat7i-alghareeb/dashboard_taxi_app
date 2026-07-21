import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/error/global_error_handler.dart';
import '../../data/datasources/customers_remote_datasource.dart';
import '../../domain/entities/customer_entity.dart';

class CustomersState {
  const CustomersState({
    this.listState = const BlocStatus<List<CustomerEntity>>.initial(),
    this.search = '',
    this.page = 1,
    this.hasMore = true,
    this.loadingMore = false,
  });

  final BlocStatus<List<CustomerEntity>> listState;
  final String search;
  final int page;
  final bool hasMore;
  final bool loadingMore;

  CustomersState copyWith({
    BlocStatus<List<CustomerEntity>>? listState,
    String? search,
    int? page,
    bool? hasMore,
    bool? loadingMore,
  }) {
    return CustomersState(
      listState: listState ?? this.listState,
      search: search ?? this.search,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
    );
  }
}

@injectable
class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit(this._dataSource) : super(const CustomersState());

  final CustomersRemoteDataSource _dataSource;
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
      final models = await _dataSource.getCustomers(
        pageSize: _pageSize,
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
      final models = await _dataSource.getCustomers(
        page: nextPage,
        search: search.isEmpty ? null : search,
      );
      return models.map((m) => m.toEntity).toList();
    });
    result.when(
      success: (items) {
        final merged = <CustomerEntity>[...current, ...items];
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

  /// Suspends or reactivates a customer, then patches its row in place.
  Future<String?> setActive({
    required String customerId,
    required bool active,
    String? reason,
  }) async {
    final error = await runAndReturnError(() async {
      if (active) {
        await _dataSource.reactivateCustomer(userId: customerId);
      } else {
        await _dataSource.suspendCustomer(userId: customerId, reason: reason);
      }
    });
    if (error != null) return error.message;

    final current = state.listState.getDataWhenSuccess;
    if (current != null) {
      final patched = current
          .map(
            (c) => c.id == customerId
                ? CustomerEntity(
                    id: c.id,
                    name: c.name,
                    phone: c.phone,
                    email: c.email,
                    role: c.role,
                    isActive: active,
                    createdAt: c.createdAt,
                    profilePhotoUrl: c.profilePhotoUrl,
                    homeAddressLabel: c.homeAddressLabel,
                    homeAddressLatitude: c.homeAddressLatitude,
                    homeAddressLongitude: c.homeAddressLongitude,
                  )
                : c,
          )
          .toList();
      emit(state.copyWith(listState: BlocStatus.success(patched)));
    }
    return null;
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
