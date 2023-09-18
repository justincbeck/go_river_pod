import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/address_provider.dart';
import 'package:go_riverpod_poc/providers/authentication_provider.dart';
import 'package:go_riverpod_poc/providers/authorization_provider.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:go_riverpod_poc/providers/smarty_provider.dart';
import 'package:go_riverpod_poc/providers/user_provider.dart';

class Debug extends ConsumerWidget {
  const Debug({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final smarty = ref.watch(smartyProvider);
    final address = ref.watch(addressProvider);
    final authentication = ref.watch(authenticationProvider);
    final home = ref.watch(homeProvider);
    final user = ref.watch(userProvider);
    final authorization = ref.watch(authorizationProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Smarty: $smarty'),
              Text('Address: $address'),
              Text('Home: $home'),
              Text('User: $user'),
              Text('Authentication: $authentication'),
              Text('Authorization: $authorization'),
              TextButton(
                onPressed: () {
                  ref.read(smartyProvider.notifier).reset();
                  ref.read(addressProvider.notifier).reset();
                  ref.read(authenticationProvider.notifier).reset();
                  ref.read(homeProvider.notifier).reset();
                  ref.read(userProvider.notifier).reset();
                  ref.read(authorizationProvider.notifier).reset();
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
