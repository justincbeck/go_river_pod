import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/auth_provider.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:go_riverpod_poc/providers/user_provider.dart';
import 'package:go_router/go_router.dart';

/// The details screen for either the A or B screen.
class HomeScreen extends ConsumerStatefulWidget {
  /// Constructs a [DetailsScreen].
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomeScreenState();
}

/// The state for DetailsScreen
class HomeScreenState extends ConsumerState<HomeScreen> {
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
            Text(ref.read(authProvider).toString()),
            Text(ref.watch(homeProvider).toString()),
            Text(ref.watch(userProvider).toString()),
            Builder(builder: (context) {
              if (ref.read(authProvider).isLoading) {
                return const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                );
              }
              return TextButton(
                onPressed: () async {
                  await ref.read(authProvider.notifier).logout();
                  if (mounted) {
                    context.go('/');
                  }
                },
                child: const Text('Logout'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
