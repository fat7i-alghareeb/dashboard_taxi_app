import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';

class RefundsPageEntity {
  const RefundsPageEntity({
    required this.items,
    required this.totalCount,
    required this.page,
    required this.pageSize,
  });

  final List<RefundEntity> items;
  final int totalCount;
  final int page;
  final int pageSize;

  bool get hasMore => page * pageSize < totalCount;
}
