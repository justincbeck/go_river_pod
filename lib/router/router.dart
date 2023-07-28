// private navigators
import 'package:flutter/material.dart';
import 'package:go_riverpod_poc/models/auth_model.dart';
import 'package:go_riverpod_poc/providers/auth_provider.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:go_riverpod_poc/providers/smarty_provider.dart';
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
    /// Setting up listeners so that if any of these providers
    /// have a change, we trigger a navigation redirect (if necessary)
    ref.listen(smartyProvider, (previous, next) {
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
        /// All of this redirect logic is used for auth (login and signup)
        /// Other redirect logic will be done at the route level
        final smarty = ref.read(smartyProvider);
        final auth = ref.read(authProvider);
        final home = ref.read(homeProvider);

        if ([AuthState.loggingIn].contains(auth.requireValue.authState)) {
          if (auth.isLoading) {
            return '/loading';
          }
          return '/login';
        }

        if ([AuthState.loggedIn].contains(auth.requireValue.authState)) {
          return '/dashboard';
        }

        if ([AuthState.loggingOut].contains(auth.requireValue.authState)) {
          return '/loading';
        }

        if ([AuthState.loggedOut].contains(auth.requireValue.authState)) {
          return '/';
        }

        if ([AuthState.signingUp].contains(auth.requireValue.authState)) {
          if (auth.isLoading || home.isLoading) {
            return '/loading';
          }
          if ((smarty.value == null && home.value == null) || home.hasError) {
            return '/enter_address';
          }
          if (auth.requireValue.username == null) {
            return '/sign_up';
          }
          if (auth.requireValue.username != null && home.hasValue) {
            return '/dashboard';
          }
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
              path: 'login',
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
