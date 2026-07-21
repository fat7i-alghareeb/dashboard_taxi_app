import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/router/safe_pop.dart';
import 'package:dashboardtaxi/features/chat/presentation/states/chat_bloc.dart';
import 'package:dashboardtaxi/features/chat/presentation/ui/widgets/chat_sheet.dart';

class TripChatScreenArgs {
  const TripChatScreenArgs({required this.tripId});

  final String tripId;
}

class TripChatScreen extends StatefulWidget {
  const TripChatScreen({super.key, required this.args});

  static const String pagePath = '/trip-chat';
  static const String pageName = 'TripChatScreen';

  final TripChatScreenArgs args;

  @override
  State<TripChatScreen> createState() => _TripChatScreenState();
}

class _TripChatScreenState extends State<TripChatScreen> {
  late final ChatBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<ChatBloc>()..add(ChatEvent.opened(widget.args.tripId));
    _bloc.add(const ChatEvent.viewOpened());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This screen is reachable from a notification tap, which enters it with
    // `go` — the stack can be one deep, where the default pop would empty the
    // navigator and show a black screen. Route both the system back gesture and
    // the sheet's X through safePop.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) safePop(context);
      },
      child: AppScaffold.body(
        child: BlocProvider<ChatBloc>.value(
          value: _bloc,
          child: ChatSheet(fullScreen: true, onClose: () => safePop(context)),
        ),
      ),
    );
  }
}
