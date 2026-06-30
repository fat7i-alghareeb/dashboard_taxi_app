import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/presentation/states/refunds_cubit.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/detail/refund_detail_header_section.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/detail/refund_detail_info_section.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/detail/refund_detail_shimmer_widget.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/detail/refund_detail_summary_grid.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/detail/refund_retry_section.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/shared/refund_ui_formatters.dart';

class RefundDetailBody extends StatelessWidget {
  const RefundDetailBody({super.key, required this.refundId});

  final String refundId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RefundsCubit, RefundsState>(
      listenWhen: (previous, current) =>
          previous.retryState != current.retryState,
      listener: (context, state) {
        state.retryState.whenOrNull(
          success: (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppStrings.refundsRetrySubmitted)),
            );
            context.read<RefundsCubit>().clearRetryState();
          },
          failure: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
            context.read<RefundsCubit>().clearRetryState();
          },
        );
      },
      builder: (context, state) {
        final cubit = context.read<RefundsCubit>();
        return RefreshIndicator(
          onRefresh: () => cubit.loadRefundDetail(refundId),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: REdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.lg,
            ),
            children: [
              RefundDetailHeaderSection(
                onRefresh: () => cubit.loadRefundDetail(refundId),
              ),
              AppSpacing.lg.verticalSpace,
              StatusBuilder<RefundEntity>(
                state: state.detailState,
                loading: () => const RefundDetailShimmerWidget(),
                onError: () => cubit.loadRefundDetail(refundId),
                success: (refund) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RefundDetailSummaryGrid(refund: refund),
                    AppSpacing.lg.verticalSpace,
                    RefundRetrySection(
                      refund: refund,
                      isLoading: state.retryState.isLoading,
                      onRetry: () => _confirmRetry(context, refund),
                    ),
                    AppSpacing.lg.verticalSpace,
                    RefundDetailInfoSection(
                      title: AppStrings.refundsPaymentSection,
                      rows: [
                        RefundInfoRowData(
                          AppStrings.refundsOriginalPaymentAmount,
                          RefundUiFormatters.optionalAmount(
                            refund.originalPaymentAmount,
                            refund.currency,
                          ),
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsRefundedTotal,
                          RefundUiFormatters.optionalAmount(
                            refund.refundedTotal,
                            refund.currency,
                          ),
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsRemainingBalance,
                          RefundUiFormatters.optionalAmount(
                            refund.remainingRefundableBalance,
                            refund.currency,
                          ),
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsPaymentMethod,
                          refund.paymentMethod ?? AppStrings.refundsNotAvailable,
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsPaymentId,
                          refund.paymentId ?? AppStrings.refundsNotAvailable,
                        ),
                      ],
                    ),
                    AppSpacing.lg.verticalSpace,
                    RefundDetailInfoSection(
                      title: AppStrings.refundsStripeSection,
                      rows: [
                        RefundInfoRowData(
                          AppStrings.refundsStripeRefundId,
                          refund.stripeRefundId ??
                              AppStrings.refundsNotAvailable,
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsStripePaymentIntentId,
                          refund.stripePaymentIntentId ??
                              AppStrings.refundsNotAvailable,
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsStripeChargeId,
                          refund.stripeChargeId ??
                              AppStrings.refundsNotAvailable,
                        ),
                      ],
                    ),
                    AppSpacing.lg.verticalSpace,
                    RefundDetailInfoSection(
                      title: AppStrings.refundsFailureSection,
                      rows: [
                        RefundInfoRowData(
                          AppStrings.refundsFailureCode,
                          refund.failureCode ?? AppStrings.refundsNotAvailable,
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsFailureReason,
                          refund.failureReason ??
                              AppStrings.refundsNotAvailable,
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsAttemptCount,
                          refund.attemptCount.toString(),
                        ),
                      ],
                    ),
                    AppSpacing.lg.verticalSpace,
                    RefundDetailInfoSection(
                      title: AppStrings.refundsTimelineSection,
                      rows: [
                        RefundInfoRowData(
                          AppStrings.refundsRequested,
                          RefundUiFormatters.date(refund.requestedAtUtc),
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsLastAttempt,
                          RefundUiFormatters.date(refund.lastAttemptAtUtc),
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsCompleted,
                          RefundUiFormatters.date(refund.completedAtUtc),
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsFailedAt,
                          RefundUiFormatters.date(refund.failedAtUtc),
                        ),
                      ],
                    ),
                    AppSpacing.lg.verticalSpace,
                    RefundDetailInfoSection(
                      title: AppStrings.refundsLinksSection,
                      rows: [
                        RefundInfoRowData(
                          AppStrings.refundsTrip,
                          refund.tripId ?? AppStrings.refundsNotAvailable,
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsPassenger,
                          refund.passengerId ??
                              AppStrings.refundsNotAvailable,
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsCancellation,
                          refund.tripCancellationId ??
                              AppStrings.refundsNotAvailable,
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsIncident,
                          refund.customerIncidentId ??
                              AppStrings.refundsNotAvailable,
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsCompensation,
                          refund.tripCompensationClaimId ??
                              AppStrings.refundsNotAvailable,
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsRequestedByAdmin,
                          refund.requestedByAdminId ??
                              AppStrings.refundsNotAvailable,
                        ),
                        RefundInfoRowData(
                          AppStrings.refundsAdminNote,
                          refund.adminNote ?? AppStrings.refundsNotAvailable,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.xxl.verticalSpace,
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmRetry(BuildContext context, RefundEntity refund) async {
    final confirmed = await AppDialog.show<bool>(
      context,
      dialog: AppDialog.basic(
        title: AppStrings.refundsRetryTitle,
        message: AppStrings.refundsRetryConfirm,
        icon: IconSource.builder(
          (_) => FaIcon(FontAwesomeIcons.rotateRight, size: 36.r),
        ),
        secondaryAction: AppDialogAction.secondary(
          label: AppStrings.cancel,
          onPressed: () => Navigator.pop(context, false),
        ),
        primaryAction: AppDialogAction.primary(
          label: AppStrings.refundsRetry,
          onPressed: () => Navigator.pop(context, true),
        ),
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await context.read<RefundsCubit>().retryRefund(refund.refundId);
  }
}
