import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/core/services/session/auth_manager.dart';
import 'package:dashboardtaxi/core/services/media/media_picker_service.dart';
import 'package:dashboardtaxi/features/chat/domain/entities/chat_message_entity.dart';
import 'package:dashboardtaxi/features/chat/presentation/states/chat_bloc.dart';
import 'package:image_picker/image_picker.dart';

/// Bottom-sheet chat surface for the active trip. Reuses the existing [ChatBloc]
/// instance so the unread badge on the trigger and the live messages stay in
/// sync. Locks the input once the trip ends ([ChatState.isClosed]).
class ChatSheet extends StatefulWidget {
  const ChatSheet({
    super.key,
    this.fullScreen = false,
    this.onClose,
    this.customerName,
  });

  final bool fullScreen;

  /// Called when the close button is tapped. Uses a captured [BuildContext]
  /// from the modal builder so it always resolves the correct navigator route.
  final VoidCallback? onClose;

  /// When provided, the header shows "klant naam : [customerName]" instead of
  /// the generic chat title. Used in admin/driver context to identify who is
  /// being chatted with.
  final String? customerName;

  static Future<void> show(
    BuildContext context, {
    required ChatBloc bloc,
    String? customerName,
  }) {
    bloc.add(const ChatEvent.viewOpened());
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (builderContext) => BlocProvider<ChatBloc>.value(
        value: bloc,
        child: ChatSheet(
          customerName: customerName,
          onClose: () => Navigator.of(builderContext).pop(),
        ),
      ),
    ).whenComplete(() {
      if (!bloc.isClosed) bloc.add(const ChatEvent.viewClosed());
    });
  }

  @override
  State<ChatSheet> createState() => _ChatSheetState();
}

class _ChatSheetState extends State<ChatSheet> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _autoScrolling = false;
  String? get _myUserId => getIt<AuthManager>().currentUser?.id;

  static const _quickMessageKeys = [
    'chatQuickOnMyWay',
    'chatQuickImHere',
    'chatQuickWave',
    'chatQuickFewMinutes',
    'chatQuickSendPhoto',
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    // Guard against animation pile-up: a burst of messages would otherwise queue
    // overlapping animateTo calls and jank the UI.
    if (_autoScrolling) return;
    _autoScrolling = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!_scrollController.hasClients) {
        _autoScrolling = false;
        return;
      }
      try {
        await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      } finally {
        _autoScrolling = false;
      }
    });
  }

  void _sendText([String? quickText]) {
    final text = quickText ?? _controller.text.trim();
    if (text.isEmpty) return;
    context.read<ChatBloc>().add(ChatEvent.sendText(text));
    if (quickText == null) _controller.clear();
  }

  Future<void> _pickPhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.camera),
              title: Text('chatChooseCamera'.tr()),
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.image),
              title: Text('chatChooseGallery'.tr()),
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null || !mounted) return;

    final result = await appMediaPickerService.pickSingle(source);
    if (!mounted) return;
    if (result.failure != null) {
      showErrorOverlay(context, AppStrings.chatSendFailed);
      return;
    }
    if (!result.isSuccess) return;
    context.read<ChatBloc>().add(ChatEvent.sendPhoto(result.files.single.path));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final viewInsets = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets),
      child: Container(
        // Subtract viewInsets so total height never exceeds screen height when
        // the keyboard is visible — without this the header gets clipped.
        height: widget.fullScreen
            ? double.infinity
            : MediaQuery.sizeOf(context).height * 0.8 - viewInsets,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: widget.fullScreen
              ? BorderRadius.zero
              : BorderRadius.vertical(top: Radius.circular(AppRadii.xl.r)),
        ),
        child: BlocConsumer<ChatBloc, ChatState>(
          listenWhen: (prev, curr) =>
              prev.messages.length != curr.messages.length ||
              prev.sendStatus != curr.sendStatus,
          listener: (context, state) {
            if (state.messages.isNotEmpty) _scrollToBottom();
            if (state.sendStatus.isFailed) {
              showErrorOverlay(
                context,
                state.sendStatus.errorMessage ?? 'chatSendFailed'.tr(),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                _buildDragHandle(context),
                _buildHeader(context),
                _buildWarningBanner(context),
                Expanded(child: _buildMessages(context, state)),
                if (!state.isClosed) _buildQuickMessages(context, state),
                if (state.isClosed)
                  _buildClosedNotice(context)
                else
                  _buildInputBar(context, state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDragHandle(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(top: AppSpacing.md),
      child: Center(
        child: Container(
          width: 40.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: context.colorScheme.onSurface.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppRadii.sm.r),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colors = context.colorScheme;
    final name = widget.customerName;

    return Padding(
      padding: REdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.xs,
      ),
      child: Row(
        children: [
          if (name != null && name.isNotEmpty) ...[
            Text(
              '${'chatCustomerLabel'.tr()} :',
              style: AppTextStyles.s12w500.copyWith(color: context.primary),
            ),
            AppSpacing.sm.horizontalSpace,
            Expanded(
              child: Text(
                name,
                style: AppTextStyles.s18w600.copyWith(color: colors.onSurface),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ] else
            Expanded(
              child: Text(
                'chatTitle'.tr(),
                style: AppTextStyles.s18w600.copyWith(color: colors.onSurface),
              ),
            ),
          IconButton(
            onPressed: widget.onClose ?? () => Navigator.of(context).pop(),
            icon: Icon(Icons.close, color: colors.onSurface, size: 22.r),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minWidth: 36.r, minHeight: 36.r),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningBanner(BuildContext context) {
    final primary = context.primary;
    return Padding(
      padding: REdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.xs,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Container(
        padding: REdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(color: primary, width: 1),
          borderRadius: BorderRadius.circular(AppRadii.md.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28.r,
              height: 28.r,
              decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
              child: Center(
                child: Text(
                  'i',
                  style: AppTextStyles.s14w600.copyWith(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            Expanded(
              child: Text(
                'chatWarningMessage'.tr(),
                style: AppTextStyles.s12w400.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickMessages(BuildContext context, ChatState state) {
    final isSending = state.sendStatus.isLoading;
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 6.h,
        children: _quickMessageKeys.map((key) {
          return _QuickMessageButton(
            label: key.tr(),
            onTap: isSending ? null : () => _sendText(key.tr()),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMessages(BuildContext context, ChatState state) {
    if (state.loadStatus.isLoading && state.messages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.messages.isEmpty) {
      return Center(
        child: Text(
          'chatEmptyState'.tr(),
          style: AppTextStyles.s14w400.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      );
    }
    return ListView.builder(
      controller: _scrollController,
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      itemCount: state.messages.length,
      itemBuilder: (context, index) {
        final message = state.messages[index];
        final isMine = message.senderId == _myUserId;
        return _ChatBubble(message: message, isMine: isMine);
      },
    );
  }

  Widget _buildClosedNotice(BuildContext context) {
    final colors = context.colorScheme;
    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(AppSpacing.lg),
      color: colors.surfaceContainerHighest.withValues(alpha: 0.4),
      child: Text(
        'chatClosedNotice'.tr(),
        textAlign: TextAlign.center,
        style: AppTextStyles.s14w400.copyWith(
          color: colors.onSurface.withValues(alpha: 0.6),
        ),
      ),
    );
  }

  Widget _buildInputBar(BuildContext context, ChatState state) {
    final isSending = state.sendStatus.isLoading;
    return SafeArea(
      top: false,
      child: Padding(
        padding: REdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.sm,
        ),
        child: Row(
          children: [
            _CircleActionButton(
              icon: Icons.add,
              onPressed: isSending ? null : _pickPhoto,
            ),
            AppSpacing.sm.horizontalSpace,
            Expanded(
              child: TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendText(),
                decoration: InputDecoration(
                  hintText: 'chatInputHint'.tr(),
                  filled: true,
                  fillColor: context.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.4),
                  contentPadding: REdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.lg.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            _CircleActionButton(
              icon: Icons.send_rounded,
              onPressed: isSending ? null : _sendText,
              isLoading: isSending,
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  const _CircleActionButton({
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final primary = context.primary;
    final disabled = onPressed == null;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 42.r,
        height: 42.r,
        decoration: BoxDecoration(
          color: disabled ? primary.withValues(alpha: 0.4) : primary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 18.r,
                  height: 18.r,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Icon(icon, color: Colors.white, size: 20.r),
        ),
      ),
    );
  }
}

class _QuickMessageButton extends StatelessWidget {
  const _QuickMessageButton({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: context.primary, width: 1),
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
        ),
        child: Text(
          label,
          style: AppTextStyles.s12w500.copyWith(
            color: context.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message, required this.isMine});

  final ChatMessageEntity message;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final bubbleColor = isMine
        ? colors.primary
        : colors.surfaceContainerHighest.withValues(alpha: 0.5);
    final textColor = isMine ? colors.onPrimary : colors.onSurface;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: REdgeInsets.only(bottom: AppSpacing.sm),
        padding: REdgeInsets.all(AppSpacing.sm),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.72,
        ),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
        ),
        child: Column(
          crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (message.photoUrl != null && message.photoUrl!.isNotEmpty)
              Padding(
                padding: REdgeInsets.only(bottom: AppSpacing.xs),
                child: AppImageViewer.network(
                  message.photoUrl!,
                  // CachedNetworkImage bypasses the Dio client, so it must send
                  // the ngrok skip header itself or the free tunnel returns its
                  // HTML warning page instead of the image. No-op in production.
                  headers: const {'ngrok-skip-browser-warning': '69420'},
                  width: 180,
                  height: 180,
                  borderRadius: AppRadii.md.r,
                  enableFullScreen: true,
                ),
              ),
            if (message.content != null && message.content!.isNotEmpty)
              Text(
                message.content!,
                style: AppTextStyles.s14w400.copyWith(color: textColor),
              ),
            AppSpacing.xs.verticalSpace,
            Text(
              _formatTime(message.sentAtUtc.toLocal()),
              style: AppTextStyles.s11w500.copyWith(
                color: textColor.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
