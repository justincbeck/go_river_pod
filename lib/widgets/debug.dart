import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/auth_provider.dart';
import 'package:go_riverpod_poc/providers/home_error_provider.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:go_riverpod_poc/providers/user_error_provider.dart';
import 'package:go_riverpod_poc/providers/user_provider.dart';

class Debug extends ConsumerWidget {
  const Debug({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Auth: ${ref.watch(authProvider).value}'),
            Text('User: ${ref.watch(userProvider).value}'),
            Text('Home: ${ref.watch(homeProvider).value}'),
            Text('Home Error: ${ref.watch(homeErrorProvider)}'),
            Text('User Error: ${ref.watch(userErrorProvider)}'),
            TextButton(
              onPressed: () {
                ref.read(authProvider.notifier).reset();
                ref.read(homeProvider.notifier).reset();
                ref.read(userProvider.notifier).reset();
                ref.read(homeErrorProvider.notifier).reset();
                ref.read(userErrorProvider.notifier).reset();
              },
              child: const Text('reset'),
            ),
          ],
        ),
      ),
    );
  }
}
