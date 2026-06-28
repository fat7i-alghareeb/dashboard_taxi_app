import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/core/services/media/audio_playback_service.dart';
import 'package:dashboardtaxi/features/recordings/presentation/ui/widgets/recording_player_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/customer_incident_entity.dart';
import '../../states/customer_incident_detail_cubit.dart';
import 'incident_ui.dart';

class IncidentDetailScreen extends StatelessWidget {
  const IncidentDetailScreen({required this.incidentId, super.key});

  static const String pagePath = '/customer_incident_detail';
  static const String pageName = 'IncidentDetailScreen';

  final String incidentId;

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      child: BlocProvider(
        create: (_) => getIt<CustomerIncidentDetailCubit>()..load(incidentId),
        child: _DetailBody(incidentId: incidentId),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.incidentId});

  final String incidentId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerIncidentDetailCubit, CustomerIncidentDetailState>(
      listenWhen: (prev, curr) => prev.actionState != curr.actionState,
      listener: (context, state) {
        state.actionState.maybeWhen(
          orElse: () {},
          loading: () => showLoadingOverlay(context, AppStrings.incidentWorking),
          success: (_) {
            clearAllOverlays();
            showSuccessOverlay(context, AppStrings.done);
          },
          failure: (msg) {
            clearAllOverlays();
            showErrorOverlay(context, msg);
          },
        );
      },
      builder: (context, state) {
        final cubit = context.read<CustomerIncidentDetailCubit>();
        final recordings =
            state.detailState.getDataWhenSuccess?.recordings ??
            const <IncidentRecordingEntity>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              onBack: () => Navigator.maybePop(context),
              onRefresh: () => cubit.load(incidentId),
              recordings: recordings,
            ),
            Expanded(
              child: StatusBuilder<CustomerIncidentDetailEntity>(
                state: state.detailState,
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (detail) => _DetailContent(
                  detail: detail,
                  isBusy: state.actionState.isLoading,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.onBack,
    required this.onRefresh,
    this.recordings = const [],
  });

  final VoidCallback onBack;
  final VoidCallback onRefresh;
  final List<IncidentRecordingEntity> recordings;

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
            icon: FaIcon(context.chevronStart, size: 18.r, color: context.onSurface),
          ),
          Expanded(
            child: Text(
              AppStrings.incidentDetails,
              style: AppTextStyles.s18w600.copyWith(color: context.onSurface),
            ),
          ),
          IconButton(
            onPressed: onRefresh,
            icon: FaIcon(
              FontAwesomeIcons.arrowsRotate,
              size: 18.r,
              color: context.onSurface.withValues(alpha: 0.70),
            ),
          ),
          // Recordings shortcut — last action in the header. Opens a sheet with
          // the customer's saved audio recordings for this incident.
          IconButton(
            tooltip: AppStrings.incidentRecordings,
            onPressed: () => _showRecordingsSheet(context, recordings),
            icon: Badge(
              isLabelVisible: recordings.isNotEmpty,
              label: Text('${recordings.length}'),
              child: FaIcon(
                FontAwesomeIcons.microphoneLines,
                size: 18.r,
                color: context.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.detail, required this.isBusy});

  final CustomerIncidentDetailEntity detail;
  final bool isBusy;

  CustomerIncidentEntity get incident => detail.incident;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: REdgeInsets.all(AppSpacing.lg),
      children: [
        _SummaryCard(incident: incident),
        AppSpacing.md.verticalSpace,
        _CustomerCard(detail: detail),
        // Recordings are reached via the microphone action in the header.
        if (detail.locations.isNotEmpty) ...[
          AppSpacing.md.verticalSpace,
          _Section(
            title: AppStrings.incidentLocations,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final l in detail.locations) _LocationTile(location: l),
              ],
            ),
          ),
        ],
        if (detail.chatMessages.isNotEmpty) ...[
          AppSpacing.md.verticalSpace,
          _Section(
            title: AppStrings.incidentChat,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final m in detail.chatMessages) _ChatTile(message: m),
              ],
            ),
          ),
        ],
        if (incident.notes != null && incident.notes!.isNotEmpty) ...[
          AppSpacing.md.verticalSpace,
          _Section(
            title: AppStrings.incidentInternalNotes,
            child: Text(
              incident.notes!,
              style: AppTextStyles.s12w500.copyWith(
                color: context.onSurface.withValues(alpha: 0.75),
              ),
            ),
          ),
        ],
        AppSpacing.lg.verticalSpace,
        _Actions(detail: detail, isBusy: isBusy),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.incident});

  final CustomerIncidentEntity incident;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 10.r,
                height: 10.r,
                decoration: BoxDecoration(
                  color: IncidentUi.severityColor(incident.severity),
                  shape: BoxShape.circle,
                ),
              ),
              AppSpacing.sm.horizontalSpace,
              Expanded(
                child: Text(
                  IncidentUi.typeLabel(incident.type),
                  style: AppTextStyles.s12w500.copyWith(
                    color: context.onSurface.withValues(alpha: 0.60),
                  ),
                ),
              ),
              Text(
                IncidentUi.statusLabel(incident.status),
                style: AppTextStyles.s12w500.copyWith(
                  color: IncidentUi.statusColor(incident.status),
                ),
              ),
            ],
          ),
          AppSpacing.sm.verticalSpace,
          Text(
            incident.title,
            style: AppTextStyles.s16w600.copyWith(color: context.onSurface),
          ),
          if (incident.reason != null && incident.reason!.isNotEmpty) ...[
            AppSpacing.xs.verticalSpace,
            Text(
              incident.reason!,
              style: AppTextStyles.s14w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.80),
              ),
            ),
          ],
          if (incident.amountLabel != null) ...[
            AppSpacing.sm.verticalSpace,
            Text(
              incident.amountLabel!,
              style: AppTextStyles.s14w600.copyWith(color: AppColors.success),
            ),
          ],
          AppSpacing.sm.verticalSpace,
          Text(
            IncidentUi.formatDate(incident.createdAt),
            style: AppTextStyles.s11w500.copyWith(
              color: context.onSurface.withValues(alpha: 0.45),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomerCard extends StatelessWidget {
  const _CustomerCard({required this.detail});

  final CustomerIncidentDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    final incident = detail.incident;
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _kv(
            context,
            AppStrings.incidentCustomer,
            incident.passengerName ?? incident.passengerId,
          ),
          if (detail.passengerPhone != null)
            _kv(context, AppStrings.incidentPhone, detail.passengerPhone!),
          if (incident.tripReferenceCode != null)
            _kv(context, AppStrings.incidentTrip, '#${incident.tripReferenceCode}'),
          if (detail.tripStatus != null)
            _kv(context, AppStrings.incidentTripStatus, detail.tripStatus!),
        ],
      ),
    );
  }

  Widget _kv(BuildContext context, String key, String value) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90.w,
            child: Text(
              key,
              style: AppTextStyles.s12w500.copyWith(
                color: context.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.s14w400.copyWith(color: context.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationTile extends StatelessWidget {
  const _LocationTile({required this.location});

  final IncidentLocationEntity location;

  @override
  Widget build(BuildContext context) {
    final label = location.addressLabel?.isNotEmpty == true
        ? location.addressLabel!
        : '${location.latitude}, ${location.longitude}';
    return InkWell(
      onTap: () => _openUrl(
        context,
        'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}',
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.locationDot,
              size: 14.r,
              color: context.primary,
            ),
            AppSpacing.sm.horizontalSpace,
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.s14w400.copyWith(color: context.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  const _ChatTile({required this.message});

  final IncidentChatMessageEntity message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${message.senderRole} • ${IncidentUi.formatDate(message.sentAt)}',
            style: AppTextStyles.s11w500.copyWith(
              color: context.onSurface.withValues(alpha: 0.45),
            ),
          ),
          if (message.content != null && message.content!.isNotEmpty)
            Text(
              message.content!,
              style: AppTextStyles.s14w400.copyWith(color: context.onSurface),
            ),
          if (message.photoUrl != null)
            InkWell(
              onTap: () => _openUrl(context, message.photoUrl!),
              child: Text(
                AppStrings.incidentViewPhoto,
                style: AppTextStyles.s12w500.copyWith(color: context.primary),
              ),
            ),
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({required this.detail, required this.isBusy});

  final CustomerIncidentDetailEntity detail;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CustomerIncidentDetailCubit>();
    final incident = detail.incident;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!incident.isClosed) ...[
          Row(
            children: [
              Expanded(
                child: AppButton.outline(
                  layout: const AppButtonLayout(height: 44),
                  onTap: isBusy
                      ? null
                      : () => cubit.changeStatus(
                          incidentId: incident.id,
                          status: 'InReview',
                        ),
                  child: AppButtonChild.label(
                    AppStrings.incidentStatusInReview,
                    textStyle: AppTextStyles.s14w500,
                  ),
                ),
              ),
              AppSpacing.sm.horizontalSpace,
              Expanded(
                child: AppButton.primary(
                  layout: const AppButtonLayout(height: 44),
                  onTap: isBusy
                      ? null
                      : () async {
                          final note = await _promptText(
                            context,
                            title: AppStrings.incidentResolveTitle,
                            hint: AppStrings.incidentResolutionNoteHint,
                          );
                          if (note == null) return;
                          await cubit.changeStatus(
                            incidentId: incident.id,
                            status: 'Resolved',
                            note: note.isEmpty ? null : note,
                          );
                        },
                  child: AppButtonChild.label(
                    AppStrings.incidentActionResolve,
                    textStyle: AppTextStyles.s14w600,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.sm.verticalSpace,
          AppButton.outline(
            variant: AppButtonVariant.error,
            layout: const AppButtonLayout(height: 44),
            onTap: isBusy
                ? null
                : () async {
                    final note = await _promptText(
                      context,
                      title: AppStrings.incidentDismissTitle,
                      hint: AppStrings.incidentReasonOptionalHint,
                    );
                    if (note == null) return;
                    await cubit.changeStatus(
                      incidentId: incident.id,
                      status: 'Dismissed',
                      note: note.isEmpty ? null : note,
                    );
                  },
            child: AppButtonChild.label(
              AppStrings.incidentActionDismiss,
              textStyle: AppTextStyles.s14w500,
            ),
          ),
          AppSpacing.md.verticalSpace,
        ],
        AppButton.outline(
          layout: const AppButtonLayout(height: 44),
          onTap: isBusy
              ? null
              : () async {
                  final msg = await _promptMessage(context);
                  if (msg == null) return;
                  await cubit.contact(
                    incidentId: incident.id,
                    title: msg.$1,
                    body: msg.$2,
                  );
                },
          child: AppButtonChild.label(
            AppStrings.incidentContactCustomer,
            textStyle: AppTextStyles.s14w500,
          ),
        ),
        if (incident.tripId != null) ...[
          AppSpacing.sm.verticalSpace,
          AppButton.outline(
            layout: const AppButtonLayout(height: 44),
            onTap: isBusy
                ? null
                : () async {
                    final amount = await _promptRefund(context);
                    if (amount == null) return;
                    await cubit.refund(
                      incidentId: incident.id,
                      amount: amount < 0 ? null : amount,
                    );
                  },
            child: AppButtonChild.label(
              AppStrings.incidentRefund,
              textStyle: AppTextStyles.s14w500,
            ),
          ),
        ],
        AppSpacing.md.verticalSpace,
        Row(
          children: [
            Expanded(
              child: AppButton.outline(
                variant: AppButtonVariant.error,
                layout: const AppButtonLayout(height: 44),
                onTap: isBusy
                    ? null
                    : () async {
                        final reason = await _promptText(
                          context,
                          title: AppStrings.incidentSuspendTitle,
                          hint: AppStrings.incidentReasonOptionalHint,
                        );
                        if (reason == null) return;
                        await cubit.suspend(
                          userId: incident.passengerId,
                          reason: reason.isEmpty ? null : reason,
                        );
                      },
                child: AppButtonChild.label(
                  AppStrings.incidentSuspend,
                  textStyle: AppTextStyles.s14w500,
                ),
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            Expanded(
              child: AppButton.outline(
                layout: const AppButtonLayout(height: 44),
                onTap: isBusy
                    ? null
                    : () => cubit.reactivate(userId: incident.passengerId),
                child: AppButtonChild.label(
                  AppStrings.incidentReactivate,
                  textStyle: AppTextStyles.s14w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: AppTextStyles.s12w500.copyWith(
              color: context.onSurface.withValues(alpha: 0.60),
            ),
          ),
          AppSpacing.xs.verticalSpace,
          child,
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: child,
    );
  }
}

void _showRecordingsSheet(
  BuildContext context,
  List<IncidentRecordingEntity> recordings,
) {
  AppBottomSheet.show<void>(
    context,
    sheet: AppBottomSheet.basic(
      title: AppStrings.incidentRecordings,
      child: recordings.isEmpty
          ? Padding(
              padding: REdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Center(
                child: EmptyStateWidget(text: AppStrings.incidentNoRecordings),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final r in recordings)
                  RecordingPlayerTile(
                    id: r.id,
                    url: r.fileUrl,
                    title: r.type,
                    subtitle: [
                      if (r.recordedAt != null) IncidentUi.formatDate(r.recordedAt),
                      if (r.durationSeconds != null) '${r.durationSeconds}s',
                    ].join('  •  '),
                    durationSeconds: r.durationSeconds,
                  ),
              ],
            ),
    ),
    // Stop any in-app playback once the sheet is dismissed.
  ).whenComplete(() => getIt<AudioPlaybackService>().stop());
}

Future<void> _openUrl(BuildContext context, String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!opened && context.mounted) {
    showErrorOverlay(context, AppStrings.somethingWentWrong);
  }
}

/// Returns the entered text (possibly empty) on confirm, or null on cancel.
Future<String?> _promptText(
  BuildContext context, {
  required String title,
  required String hint,
}) async {
  final controller = TextEditingController();
  final result = await showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        maxLines: 3,
        decoration: InputDecoration(hintText: hint),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, controller.text.trim()),
          child: Text(AppStrings.incidentConfirm),
        ),
      ],
    ),
  );
  controller.dispose();
  return result;
}

/// Returns (title, body) on confirm, or null on cancel/invalid.
Future<(String, String)?> _promptMessage(BuildContext context) async {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final result = await showDialog<(String, String)>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(AppStrings.incidentContactCustomer),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: AppStrings.incidentMessageTitleHint),
          ),
          TextField(
            controller: bodyController,
            maxLines: 3,
            decoration: InputDecoration(hintText: AppStrings.incidentMessageBodyHint),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: () {
            final t = titleController.text.trim();
            final b = bodyController.text.trim();
            if (t.isEmpty || b.isEmpty) {
              Navigator.pop(ctx);
              return;
            }
            Navigator.pop(ctx, (t, b));
          },
          child: Text(AppStrings.incidentSend),
        ),
      ],
    ),
  );
  titleController.dispose();
  bodyController.dispose();
  return result;
}

/// Returns the refund amount on confirm (-1 sentinel = full refund), or null on cancel.
Future<double?> _promptRefund(BuildContext context) async {
  final controller = TextEditingController();
  final result = await showDialog<double>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(AppStrings.incidentRefundTitle),
      content: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(hintText: AppStrings.incidentRefundAmountHint),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: () {
            final text = controller.text.trim();
            if (text.isEmpty) {
              Navigator.pop(ctx, -1.0);
              return;
            }
            final parsed = double.tryParse(text);
            Navigator.pop(ctx, parsed ?? -1.0);
          },
          child: Text(AppStrings.incidentRefund),
        ),
      ],
    ),
  );
  controller.dispose();
  return result;
}
