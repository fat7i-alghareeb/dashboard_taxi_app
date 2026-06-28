import 'package:dashboardtaxi/common/imports/imports.dart';

import '../../../domain/entities/customer_entity.dart';

/// Circular avatar for a customer: their profile photo when available,
/// otherwise a colored circle with the first letter of their name.
class CustomerAvatar extends StatelessWidget {
  const CustomerAvatar({
    super.key,
    required this.customer,
    this.size = 48,
  });

  final CustomerEntity customer;
  final double size;

  @override
  Widget build(BuildContext context) {
    final dimension = size.r;
    if (customer.hasPhoto) {
      return AppImageViewer.network(
        customer.profilePhotoUrl!,
        width: dimension,
        height: dimension,
        borderRadius: dimension,
        enableFullScreen: true,
      );
    }

    final initial = customer.name.trim().isNotEmpty
        ? customer.name.trim()[0].toUpperCase()
        : '?';
    return Container(
      width: dimension,
      height: dimension,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.primary.withValues(alpha: 0.12),
      ),
      child: Text(
        initial,
        style: AppTextStyles.s16w600.copyWith(color: context.primary),
      ),
    );
  }
}
