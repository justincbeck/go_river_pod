// private navigators
import 'package:flutter/material.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:go_riverpod_poc/providers/user_provider.dart';
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
    return GoRouter(
      initialLocation: '/',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      redirect: (context, state) async {
        final home = ref.watch(homeProvider);
        final user = ref.watch(userProvider);

        // if (auth.value?.authState == AuthState.loggedOut) {
        //   return '/';
        // }

        if (home.isLoading || user.isLoading) {
          logger.info('home.isLoading || user.isLoading');
          return '/loading';
        }

        if (home.hasError) {
          logger.info('home.hasError');
          return '/create_home';
        }

        if (user.hasError) {
          logger.info('user.hasError');
          return '/sign_up';
        }

        if (home.hasValue &&
            home.requireValue != null &&
            user.hasValue &&
            user.requireValue != null) {
          return '/dashboard';
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
              path: 'create_home',
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
