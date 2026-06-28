import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/services/media/audio_playback_service.dart';
import 'package:dashboardtaxi/features/customers/domain/entities/customer_filter_args.dart';
import 'package:dashboardtaxi/features/customers/presentation/ui/widgets/customer_picker_sheet.dart';

import '../../../domain/entities/trip_recording_entity.dart';
import '../../states/recordings_cubit.dart';
import '../widgets/recording_player_tile.dart';

class RecordingsListScreen extends StatelessWidget {
  const RecordingsListScreen({super.key, this.customerFilter});

  /// Optional customer to pre-filter the recordings by (passed via route `extra`).
  final CustomerFilterArgs? customerFilter;

  static const String pagePath = '/recordings';
  static const String pageName = 'RecordingsListScreen';

  @override
  Widget build(BuildContext context) {
    final filter = customerFilter;
    return AppScaffold.body(
      child: BlocProvider(
        create: (_) {
          final cubit = getIt<RecordingsCubit>();
          if (filter != null) {
            cubit.setCustomer(filter.passengerId, filter.name);
          } else {
            cubit.load();
          }
          return cubit;
        },
        child: const _RecordingsBody(),
      ),
    );
  }
}

class _RecordingsBody extends StatefulWidget {
  const _RecordingsBody();

  @override
  State<_RecordingsBody> createState() => _RecordingsBodyState();
}

class _RecordingsBodyState extends State<_RecordingsBody> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    // Stop any in-app playback when leaving the screen.
    getIt<AudioPlaybackService>().stop();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 300) {
      context.read<RecordingsCubit>().nextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordingsCubit, RecordingsState>(
      builder: (context, state) {
        final cubit = context.read<RecordingsCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              onBack: () => Navigator.maybePop(context),
              onRefresh: cubit.load,
            ),
            Padding(
              padding: REdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onChanged: cubit.setSearch,
                decoration: InputDecoration(
                  hintText: AppStrings.recordingsSearchHint,
                  prefixIcon: const Icon(Icons.search),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.lg.r),
                  ),
                ),
              ),
            ),
            Padding(
              padding: REdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: state.hasCustomerFilter
                    ? InputChip(
                        avatar: const FaIcon(FontAwesomeIcons.user, size: 12),
                        label: Text(
                          '${AppStrings.customerFilterLabel}: ${state.passengerName ?? state.passengerId}',
                        ),
                        onDeleted: cubit.clearCustomer,
                      )
                    : OutlinedButton.icon(
                        onPressed: () async {
                          final customer =
                              await CustomerPickerSheet.show(context);
                          if (customer == null) return;
                          cubit.setCustomer(customer.id, customer.name);
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: 14,
                        ),
                        label: Text(AppStrings.customerFilterByCustomer),
                      ),
              ),
            ),
            Expanded(
              child: StatusBuilder<List<TripRecordingEntity>>(
                state: state.listState,
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (items) {
                  if (items.isEmpty) {
                    return Center(
                      child: EmptyStateWidget(
                        text: AppStrings.recordingsNone,
                        onRefresh: cubit.load,
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: cubit.load,
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: REdgeInsets.all(AppSpacing.lg),
                      itemCount: items.length + (state.loadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= items.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return _recordingTile(items[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _recordingTile(TripRecordingEntity r) {
    final ref = r.tripReferenceCode;
    final title = (ref != null && ref.isNotEmpty)
        ? '#$ref'
        : (r.recordedAt?.toLocal().toYmd() ?? AppStrings.recordingsTitle);
    final parts = <String>[
      if (r.passengerName != null && r.passengerName!.isNotEmpty)
        r.passengerName!,
      if (r.recordedAt != null) r.recordedAt!.toLocal().toSmartDateTime(),
      if (r.durationSeconds != null) '${r.durationSeconds}s',
    ];
    return RecordingPlayerTile(
      id: r.id,
      url: r.fileUrl,
      title: title,
      subtitle: parts.join('  •  '),
      durationSeconds: r.durationSeconds,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack, required this.onRefresh});

  final VoidCallback onBack;
  final VoidCallback onRefresh;

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
              AppStrings.recordingsTitle,
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
        ],
      ),
    );
  }
}
