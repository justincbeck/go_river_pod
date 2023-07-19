import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/go_riverpod.dart';
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
    ref.watch(goRiverpodProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Builder(builder: (context) {
              if (ref.read(goRiverpodProvider).isLoading) {
                return const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                );
              }
              return TextButton(
                onPressed: () async {
                  await ref.read(goRiverpodProvider.notifier).logout();
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
