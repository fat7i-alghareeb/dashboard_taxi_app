import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dashboardtaxi/core/injection/injectable.dart';
import 'package:dashboardtaxi/features/root/presentation/states/root_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/utils/helpers/colored_print.dart';

import '../widgets/root_body.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  static const String pagePath = '/root_screen';
  static const String pageName = 'RootScreen';

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  // TripBloc is a lazySingleton, so its bootstrap events must fire once on
  // mount — not from build(). Cascading them inside BlocProvider.value re-ran
  // getAllTrips + the active-trip resolve on every rebuild, and that resolve
  // races (and overwrites) whatever trip the operator has open.
  late final TripBloc _tripBloc;

  @override
  void initState() {
    super.initState();
    _tripBloc = getIt<TripBloc>()
      ..add(const TripEvent.started())
      ..add(const TripEvent.activeTripResolveRequested());
  }

  @override
  Widget build(BuildContext context) {
    printM('[RootScreen] build');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<RootBloc>()..add(const RootEvent.started()),
        ),
        BlocProvider<TripBloc>.value(value: _tripBloc),
      ],
      child: const RootBody(),
    );
  }
}
