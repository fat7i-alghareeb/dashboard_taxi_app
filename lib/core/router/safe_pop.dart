import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/root/presentation/ui/screens/root_screen.dart';

/// Closes the current route, falling back to the root shell when there is
/// nothing to pop.
///
/// Routes opened from a notification tap are entered with `go`, which *replaces*
/// the stack — the destination is then the only route in the navigator. A bare
/// `pop()` there empties the navigator and leaves the user staring at a black
/// screen with no way back. Always close through this helper rather than
/// `Navigator.pop` / `context.pop` on any screen that a deep link can land on.
void safePop<T extends Object?>(BuildContext context, {T? result}) {
  if (context.canPop()) {
    context.pop(result);
  } else {
    context.go(RootScreen.pagePath);
  }
}
