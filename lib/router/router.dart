// private navigators
import 'package:flutter/material.dart';
import 'package:go_riverpod_poc/models/auth_model.dart';
import 'package:go_riverpod_poc/providers/address_provider.dart';
import 'package:go_riverpod_poc/providers/auth_provider.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:go_riverpod_poc/screens/create_home_screen.dart';
import 'package:go_riverpod_poc/screens/dashboard_screen.dart';
import 'package:go_riverpod_poc/screens/landing_screen.dart';
import 'package:go_riverpod_poc/screens/loading_screen.dart';
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
    ref.listen(addressProvider, (previous, next) {
      state.go('/');
    });
    ref.listen(authProvider, (previous, next) {
      if (!next.isLoading) state.go('/');
    });
    ref.listen(homeProvider, (previous, next) {
      if (!next.isLoading) state.go('/');
    });

    return GoRouter(
      initialLocation: '/',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      redirect: (context, state) async {
        final address = ref.read(addressProvider);
        final auth = ref.read(authProvider);
        final home = ref.read(homeProvider);

        // If we're just
        if (auth.requireValue.authState == AuthState.loggedIn) {
          return '/dashboard';
        }

        if (auth.requireValue.authState == AuthState.signingUp) {
          if (auth.isLoading || home.isLoading) {
            return '/loading';
          }
          if (address == null && home.value == null || home.hasError) {
            return '/enter_address';
          }
          if (auth.requireValue.username == null) {
            return '/sign_up';
          }
          if (auth.requireValue.username != null && home.hasValue) {
            return '/dashboard';
          }
        }

        if (auth.requireValue.authState == AuthState.loggedOut) {
          return '/';
        }

        return null;
      },
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
                child: CreateHomeScreen(),
              ),
            ),
            GoRoute(
              path: 'sign_up',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SignUpScreen(),
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
