import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/auth_provider.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:go_riverpod_poc/providers/smarty_provider.dart';
import 'package:go_riverpod_poc/providers/user_provider.dart';

class Debug extends ConsumerWidget {
  const Debug({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Smarty: ${ref.watch(smartyProvider)}'),
              Text('Auth: ${ref.watch(authProvider)}'),
              Text('Home: ${ref.watch(homeProvider)}'),
              Text('User: ${ref.watch(userProvider)}'),
              TextButton(
                onPressed: () {
                  ref.read(smartyProvider.notifier).reset();
                  ref.read(authProvider.notifier).reset();
                  ref.read(homeProvider.notifier).reset();
                  ref.read(userProvider.notifier).reset();
                },
                child: const Text('reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
