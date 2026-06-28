import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/customer_incidents/presentation/ui/screens/incidents_list_screen.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/screens/dashboard_trips_screen.dart';
import 'package:dashboardtaxi/features/recordings/presentation/ui/screens/recordings_list_screen.dart';

import '../../../../../core/error/global_error_handler.dart';
import '../../../data/datasources/customers_remote_datasource.dart';
import '../../../domain/entities/customer_entity.dart';
import '../../../domain/entities/customer_filter_args.dart';
import '../widgets/customer_avatar.dart';

class CustomerDetailScreen extends StatefulWidget {
  const CustomerDetailScreen({super.key, required this.customer});

  final CustomerEntity customer;

  static const String pagePath = '/customer_detail';
  static const String pageName = 'CustomerDetailScreen';

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  final CustomersRemoteDataSource _dataSource =
      getIt<CustomersRemoteDataSource>();

  late bool _isActive = widget.customer.isActive;
  bool _busy = false;

  CustomerEntity get _customer => widget.customer;

  CustomerFilterArgs get _filterArgs =>
      CustomerFilterArgs(passengerId: _customer.id, name: _customer.name);

  Future<void> _toggleActive() async {
    final suspend = _isActive;
    final confirm = await AppDialog.show<bool>(
      context,
      dialog: AppDialog.basic(
        title: suspend
            ? AppStrings.customerSuspendTitle
            : AppStrings.customerReactivateTitle,
        message: suspend
            ? AppStrings.customerSuspendConfirm
            : AppStrings.customerReactivateConfirm,
        secondaryAction: AppDialogAction.secondary(
          label: AppStrings.cancel,
          onPressed: () => Navigator.pop(context, false),
        ),
        primaryAction: suspend
            ? AppDialogAction.danger(
                label: AppStrings.customerSuspend,
                onPressed: () => Navigator.pop(context, true),
              )
            : AppDialogAction.primary(
                label: AppStrings.customerReactivate,
                onPressed: () => Navigator.pop(context, true),
              ),
      ),
    );
    if (confirm != true) return;

    setState(() => _busy = true);
    final error = await runAndReturnError(() async {
      if (suspend) {
        await _dataSource.suspendCustomer(userId: _customer.id);
      } else {
        await _dataSource.reactivateCustomer(userId: _customer.id);
      }
    });
    if (!mounted) return;
    setState(() {
      _busy = false;
      if (error == null) _isActive = !suspend;
    });
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          error?.message ??
              (suspend
                  ? AppStrings.customerSuspendedDone
                  : AppStrings.customerReactivatedDone),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Header(
            title: AppStrings.customerProfileTitle,
            onBack: () => Navigator.maybePop(context),
          ),
          Expanded(
            child: ListView(
              padding: REdgeInsets.all(AppSpacing.lg),
              children: [
                _ProfileCard(customer: _customer, isActive: _isActive),
                AppSpacing.lg.verticalSpace,
                _InfoSection(customer: _customer),
                AppSpacing.xl.verticalSpace,
                _ActionTile(
                  icon: FontAwesomeIcons.route,
                  label: AppStrings.customerViewRecords,
                  onTap: () => context.pushNamed(
                    DashboardTripsScreen.pageName,
                    extra: _filterArgs,
                  ),
                ),
                AppSpacing.sm.verticalSpace,
                _ActionTile(
                  icon: FontAwesomeIcons.triangleExclamation,
                  label: AppStrings.customerViewIncidents,
                  onTap: () => context.pushNamed(
                    CustomerIncidentsScreen.pageName,
                    extra: _filterArgs,
                  ),
                ),
                AppSpacing.sm.verticalSpace,
                _ActionTile(
                  icon: FontAwesomeIcons.microphoneLines,
                  label: AppStrings.customerViewRecordings,
                  onTap: () => context.pushNamed(
                    RecordingsListScreen.pageName,
                    extra: _filterArgs,
                  ),
                ),
                AppSpacing.sm.verticalSpace,
                _ActionTile(
                  icon: _isActive
                      ? FontAwesomeIcons.ban
                      : FontAwesomeIcons.circleCheck,
                  label: _isActive
                      ? AppStrings.customerSuspend
                      : AppStrings.customerReactivate,
                  destructive: _isActive,
                  busy: _busy,
                  onTap: _busy ? null : _toggleActive,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: FaIcon(
              context.chevronStart,
              size: 18.r,
              color: context.onSurface,
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.s18w600.copyWith(color: context.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.customer, required this.isActive});

  final CustomerEntity customer;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          CustomerAvatar(customer: customer, size: 88),
          AppSpacing.md.verticalSpace,
          Text(
            customer.name,
            textAlign: TextAlign.center,
            style: AppTextStyles.s18w600.copyWith(color: context.onSurface),
          ),
          AppSpacing.xs.verticalSpace,
          Container(
            padding: REdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: (isActive ? AppColors.success : AppColors.error)
                  .withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadii.sm.r),
            ),
            child: Text(
              isActive
                  ? AppStrings.customerActive
                  : AppStrings.customerSuspended,
              style: AppTextStyles.s11w500.copyWith(
                color: isActive ? AppColors.success : AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.customer});

  final CustomerEntity customer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          _InfoRow(
            icon: FontAwesomeIcons.phone,
            label: AppStrings.customerPhone,
            value: customer.phone,
          ),
          if (customer.hasEmail)
            _InfoRow(
              icon: FontAwesomeIcons.envelope,
              label: AppStrings.customerEmail,
              value: customer.email!,
            ),
          if (customer.hasHomeAddress)
            _InfoRow(
              icon: FontAwesomeIcons.locationDot,
              label: AppStrings.customerHomeAddress,
              value: customer.homeAddressLabel!,
            ),
          if (customer.createdAt != null)
            _InfoRow(
              icon: FontAwesomeIcons.calendar,
              label: AppStrings.customerJoined,
              value: customer.createdAt!.toLocal().toYmd(),
              isLast: true,
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final FaIconData icon;
  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: context.onSurface.withValues(alpha: 0.06),
                ),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FaIcon(
            icon,
            size: 14.r,
            color: context.onSurface.withValues(alpha: 0.45),
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.s12w500.copyWith(
                    color: context.onSurface.withValues(alpha: 0.50),
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  value,
                  style: AppTextStyles.s14w500.copyWith(color: context.onSurface),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
    this.busy = false,
  });

  final FaIconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool destructive;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? AppColors.error : context.primary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.lg.r),
      child: Container(
        padding: REdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          border: Border.all(color: color.withValues(alpha: 0.20)),
        ),
        child: Row(
          children: [
            FaIcon(icon, size: 16.r, color: color),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.s14w600.copyWith(color: color),
              ),
            ),
            if (busy)
              SizedBox(
                width: 16.r,
                height: 16.r,
                child: const CircularProgressIndicator(strokeWidth: 2),
              )
            else
              FaIcon(
                context.chevronEnd,
                size: 14.r,
                color: color.withValues(alpha: 0.55),
              ),
          ],
        ),
      ),
    );
  }
}
