import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/chat/presentation/states/chat_bloc.dart';
import 'package:dashboardtaxi/features/chat/presentation/ui/widgets/chat_sheet.dart';

/// Self-contained chat trigger usable from any active-trip surface (driver
/// trip sheet, admin dashboard). Owns a [ChatBloc] for [tripId] while mounted
/// so it can both show an unread badge and open the [ChatSheet] with the same
/// instance. Tapping opens the chat.
class ChatEntryButton extends StatefulWidget {
  const ChatEntryButton({super.key, required this.tripId, this.compact = false});

  final String tripId;

  /// When true, renders an icon-only button (for tight rows).
  final bool compact;

  @override
  State<ChatEntryButton> createState() => _ChatEntryButtonState();
}

class _ChatEntryButtonState extends State<ChatEntryButton> {
  late final ChatBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<ChatBloc>()..add(ChatEvent.opened(widget.tripId));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>.value(
      value: _bloc,
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          final unread = state.unreadCount;
          final colors = context.colorScheme;
          return InkWell(
            onTap: () => ChatSheet.show(context, bloc: _bloc),
            borderRadius: BorderRadius.circular(AppRadii.md.r),
            child: Container(
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadii.md.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidComments,
                        size: 14.r,
                        color: colors.primary,
                      ),
                      if (unread > 0)
                        PositionedDirectional(
                          top: -6.h,
                          end: -8.w,
                          child: Container(
                            padding: REdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 1,
                            ),
                            constraints: BoxConstraints(minWidth: 14.w),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(AppRadii.lg.r),
                            ),
                            child: Text(
                              unread > 99 ? '99+' : '$unread',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.s11w500.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (!widget.compact) ...[
                    AppSpacing.sm.horizontalSpace,
                    Text(
                      'chatTitle'.tr(),
                      style: AppTextStyles.s12w500.copyWith(
                        color: colors.primary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
