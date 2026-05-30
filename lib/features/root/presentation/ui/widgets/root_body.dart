import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/domain/extensions/user_role_extensions.dart';
import 'package:dashboardtaxi/core/services/session/auth_manager.dart';
import 'package:dashboardtaxi/features/root/domain/services/root_tab_controller.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';

import 'home/root_home_tab_section.dart';
import 'nav/root_bottom_nav_bar.dart';
import 'profile/root_profile_tab_section.dart';
import 'root_drawer_content.dart';
import 'trip/root_trip_tab_section.dart';

class RootBody extends StatefulWidget {
  const RootBody({super.key});

  @override
  State<RootBody> createState() => _RootBodyState();
}

class _RootBodyState extends State<RootBody> {
  late final PageController _pageController;
  late final bool _isAdmin;
  late final int _homeTabIndex;
  late final RootTabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _isAdmin = getIt<AuthManager>().currentUser.isAdmin;
    // Tabs: drivers see [Account, Home], admins see [Account, Home, Trips].
    // Home is always at index 1.
    _homeTabIndex = 1;
    _currentIndex = _homeTabIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _tabController = getIt<RootTabController>()..addListener(_onTabRequested);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabRequested);
    _pageController.dispose();
    super.dispose();
  }

  void _onTabRequested() {
    final requested = _tabController.pendingIndex;
    if (requested == null) return;
    _tabController.consume();
    _onTabSelected(requested);
  }

  void _onTabSelected(int index) {
    printM('[RootBody] _onTabSelected index=$index');
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    printM('[RootBody] _onPageChanged index=$index');
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }

  List<RootBottomNavItemConfig> _buildNavItems(int newTripsCount) {
    return <RootBottomNavItemConfig>[
      RootBottomNavItemConfig(
        label: AppStrings.tabAccount,
        icon: FontAwesomeIcons.user,
      ),
      RootBottomNavItemConfig(
        label: AppStrings.tabHome,
        icon: FontAwesomeIcons.house,
      ),
      if (_isAdmin)
        RootBottomNavItemConfig(
          label: AppStrings.drawerTrips,
          icon: FontAwesomeIcons.clock,
          badgeCount: newTripsCount,
        ),
    ];
  }

  List<Widget> _buildPages() {
    return <Widget>[
      const RootProfileTabSection(),
      const RootHomeTabSection(),
      if (_isAdmin) const RootTripTabSection(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    printM('[RootBody] build currentIndex=$_currentIndex isAdmin=$_isAdmin');
    final pages = _buildPages();

    return BlocBuilder<TripBloc, TripState>(
      buildWhen: (prev, curr) => prev.pendingTrips != curr.pendingTrips,
      builder: (context, tripState) {
        final navItems = _buildNavItems(tripState.pendingTrips.length);

        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: context.surface,
          drawer: SizedBox(
            width: context.screenWidth * 0.85,
            child: const Drawer(
              shape: RoundedRectangleBorder(),
              child: RootDrawerContent(),
            ),
          ),
          bottomNavigationBar: RootBottomNavBar(
            items: navItems,
            currentIndex: _currentIndex,
            onItemSelected: _onTabSelected,
          ),
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: _onPageChanged,
            children: pages,
          ),
        );
      },
    );
  }
}
