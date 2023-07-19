import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/auth_provider.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:go_riverpod_poc/providers/user_provider.dart';
import 'package:go_router/go_router.dart';

/// The details screen for either the A or B screen.
class DashboardScreen extends ConsumerStatefulWidget {
  /// Constructs a [DetailsScreen].
  const DashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DashboardScreenState();
}

/// The state for DetailsScreen
class DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                children: [
                  Text(ref.read(authProvider).toString()),
                  Text(ref.watch(homeProvider).toString()),
                  Text(ref.watch(userProvider).toString()),
                  ElevatedButton(
                    onPressed: () async {
                      await ref.read(authProvider.notifier).logout();
                      if (mounted) {
                        context.go('/');
                      }
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
