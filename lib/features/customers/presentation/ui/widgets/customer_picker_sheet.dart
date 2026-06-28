import 'package:dashboardtaxi/common/imports/imports.dart';

import '../../../data/datasources/customers_remote_datasource.dart';
import '../../../domain/entities/customer_entity.dart';
import 'customer_avatar.dart';

/// A searchable bottom sheet that lets an admin pick a customer (passenger).
///
/// Returns the selected [CustomerEntity], or `null` if dismissed. Reused by the
/// Records (admin trips) and Incidents screens to drive their customer filter.
class CustomerPickerSheet extends StatefulWidget {
  const CustomerPickerSheet._();

  static Future<CustomerEntity?> show(BuildContext context) {
    return AppBottomSheet.show<CustomerEntity>(
      context,
      sheet: AppBottomSheet.basic(
        title: AppStrings.customerPickerTitle,
        scrollable: false,
        child: const CustomerPickerSheet._(),
      ),
    );
  }

  @override
  State<CustomerPickerSheet> createState() => _CustomerPickerSheetState();
}

class _CustomerPickerSheetState extends State<CustomerPickerSheet> {
  final CustomersRemoteDataSource _dataSource =
      getIt<CustomersRemoteDataSource>();
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  bool _loading = true;
  String? _error;
  List<CustomerEntity> _results = const [];

  @override
  void initState() {
    super.initState();
    _search('');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () => _search(value));
  }

  Future<void> _search(String query) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final trimmed = query.trim();
    try {
      final models = await _dataSource.getCustomers(
        search: trimmed.isEmpty ? null : trimmed,
      );
      if (!mounted) return;
      setState(() {
        _results = models.map((m) => m.toEntity).toList();
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Shrink the sheet by the keyboard height so the list + chrome always fit
    // (AppBottomSheet already pads the bottom by the same inset). Without this
    // the fixed-height sheet overflows when the keyboard opens.
    final media = MediaQuery.of(context);
    final maxHeight = media.size.height * 0.6;
    final height = (maxHeight - media.viewInsets.bottom).clamp(160.0, maxHeight);
    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            textInputAction: TextInputAction.search,
            onChanged: _onChanged,
            decoration: InputDecoration(
              hintText: AppStrings.customerSearchHint,
              prefixIcon: const Icon(Icons.search),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.lg.r),
              ),
            ),
          ),
          AppSpacing.md.verticalSpace,
          Expanded(child: _buildResults(context)),
        ],
      ),
    );
  }

  Widget _buildResults(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return EmptyStateWidget(
        text: _error,
        onRetrying: () => _search(_controller.text),
        retryLabel: AppStrings.retry,
      );
    }
    if (_results.isEmpty) {
      return Center(child: EmptyStateWidget(text: AppStrings.customersNone));
    }
    return ListView.separated(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: _results.length,
      separatorBuilder: (_, _) => AppSpacing.sm.verticalSpace,
      itemBuilder: (context, index) {
        final customer = _results[index];
        return InkWell(
          onTap: () => Navigator.pop(context, customer),
          borderRadius: BorderRadius.circular(AppRadii.md.r),
          child: Padding(
            padding: REdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                CustomerAvatar(customer: customer, size: 40),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.s14w600.copyWith(
                          color: context.onSurface,
                        ),
                      ),
                      Text(
                        customer.hasEmail ? customer.email! : customer.phone,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.s12w500.copyWith(
                          color: context.onSurface.withValues(alpha: 0.60),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
