// private navigators
import 'package:flutter/material.dart';
import 'package:go_riverpod_poc/providers/authorization_provider.dart';
import 'package:go_riverpod_poc/screens/enter_address_screen.dart';
import 'package:go_riverpod_poc/screens/dashboard_screen.dart';
import 'package:go_riverpod_poc/screens/home_screen.dart';
import 'package:go_riverpod_poc/screens/landing_screen.dart';
import 'package:go_riverpod_poc/screens/loading_screen.dart';
import 'package:go_riverpod_poc/screens/login_screen.dart';
import 'package:go_riverpod_poc/screens/show_case/show_case_screen.dart';
import 'package:go_riverpod_poc/screens/sign_up_screen.dart';
import 'package:go_riverpod_poc/screens/tabbed_view.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:showcaseview/showcaseview.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
class Router extends _$Router {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _dashboardNavigatorKey = GlobalKey<NavigatorState>();
  final _tabbedViewNavigatorKey = GlobalKey<NavigatorState>();
  final _showcaseNavigatorKey = GlobalKey<NavigatorState>();
  final Logger logger = Logger('RouterProvider');

  @override
  GoRouter build() {
    ref.listen(authorizationProvider, (previous, next) {
      switch (next.value) {
        case (AuthorizationState.loading):
          // If we're loading, show the splash screen
          state.go('/loading');
        case (AuthorizationState.authenticating):
          // If we're logging in, show the '/sign_in' screen
          state.go('/sign_in');
        case (AuthorizationState.signingUp):
          // If we're signing up (and we have an address), show the '/sign_up' screen
          state.go('/sign_up');
        case (AuthorizationState.authorized):
          // If we're authenticated with a home, show the dashboard
          state.go('/dashboard');
        case (AuthorizationState.signingUpWithoutHome):
        case (AuthorizationState.authenticatedWithoutHome):
          // If we don't have an address, show the '/add_home' screen
          state.go('/enter_address');
        default:
          // If we're unauthorized (not authenticated in any way), show the landing screen
          state.go('/');
      }
    });

    return GoRouter(
      initialLocation: '/',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: LandingScreen(),
          ),
          routes: <RouteBase>[
            GoRoute(
              path: 'enter_address',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: EnterAddressScreen(),
              ),
            ),
            GoRoute(
              path: 'sign_up',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SignUpScreen(),
              ),
            ),
            GoRoute(
              path: 'sign_in',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: LoginScreen(),
              ),
            ),
          ],
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithNestedNavigation(
              navigationShell: navigationShell,
            );
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _dashboardNavigatorKey,
              routes: [
                GoRoute(
                  path: '/dashboard',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: DashboardScreen(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _tabbedViewNavigatorKey,
              routes: [
                GoRoute(
                  path: '/tabbed_view',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: TabbedViewScreen(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _showcaseNavigatorKey,
              routes: [
                GoRoute(
                  path: '/showcase_1',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: ShowCaseScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/loading',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: LoadingScreen(),
          ),
        ),
      ],
    );
  }
}

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      enableAutoScroll: true,
      builder: Builder(
        builder: (context) => HomeScreen(
          content: navigationShell,
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 7,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: NavigationBar(
              backgroundColor: Colors.white,
              indicatorColor: Colors.transparent,
              selectedIndex: navigationShell.currentIndex,
              destinations: const [
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.type_specimen_outlined,
                    color: Colors.red,
                  ),
                  icon: Icon(
                    Icons.type_specimen_outlined,
                    color: Colors.blue,
                  ),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.red,
                  ),
                  icon: Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.blue,
                  ),
                  label: 'Tabbed View',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.red,
                  ),
                  icon: Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.blue,
                  ),
                  label: 'Scroll View',
                ),
              ],
              onDestinationSelected: _goBranch,
            ),
          ),
        ),
      ),
    );
  }
}
