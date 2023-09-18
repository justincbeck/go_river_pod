// private navigators
import 'package:flutter/material.dart';
import 'package:go_riverpod_poc/providers/authorization_provider.dart';
import 'package:go_riverpod_poc/screens/enter_address_screen.dart';
import 'package:go_riverpod_poc/screens/dashboard_screen.dart';
import 'package:go_riverpod_poc/screens/landing_screen.dart';
import 'package:go_riverpod_poc/screens/loading_screen.dart';
import 'package:go_riverpod_poc/screens/login_screen.dart';
import 'package:go_riverpod_poc/screens/sign_up_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
class Router extends _$Router {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
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
        GoRoute(
          path: '/dashboard',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: DashboardScreen(),
          ),
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
