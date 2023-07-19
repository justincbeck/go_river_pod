// private navigators
import 'package:flutter/material.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:go_riverpod_poc/providers/user_provider.dart';
import 'package:go_riverpod_poc/screens/create_home_screen.dart';
import 'package:go_riverpod_poc/screens/dashboard_screen.dart';
import 'package:go_riverpod_poc/screens/landing_screen.dart';
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
    final home = ref.watch(homeProvider);
    final user = ref.watch(userProvider);

    if (home.hasError) {
      logger.info('home error => ${home.error}');
    }

    if (user.hasError) {
      logger.info('user error => ${user.error}');
    }

    return GoRouter(
      initialLocation: '/',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      redirect: (context, state) async {
        if (home.isLoading || user.isLoading) {
          logger.info('loading');
          return state.location;
        }

        if (home.hasValue && home.requireValue != null) {
          logger.info('has home');
          return '/dashboard';
        }

        if (user.hasValue && user.requireValue != null) {
          logger.info('has user');
          return '/create_home';
        }

        // if (home.hasError) {
        //   return '/create_home';
        // }

        // if (user.hasError) {
        //   return '/sign_up';
        // }
        logger.info('no home or user');
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
      ],
    );
  }
}
