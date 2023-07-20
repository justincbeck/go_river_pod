import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/auth_provider.dart';
import 'package:go_riverpod_poc/providers/home_error_provider.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:go_riverpod_poc/widgets/debug.dart';
import 'package:go_router/go_router.dart';

/// The details screen for either the A or B screen.
class SignUpScreen extends ConsumerStatefulWidget {
  /// Constructs a [DetailsScreen].
  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SignUpScreenState();
}

/// The state for DetailsScreen
class SignUpScreenState extends ConsumerState<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    ref.watch(authProvider);
    ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await ref.read(authProvider.notifier).login();
                      // if (mounted) {
                      //   context.go('/');
                      // }
                    },
                    child: const Text('Sign Up (success)'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      ref
                          .read(homeErrorProvider.notifier)
                          .setError(ErrorModel(message: 'Home: BOOM!'));
                      await ref.read(authProvider.notifier).login();
                      // if (mounted) {
                      //   context.go('/');
                      // }
                    },
                    child: const Text('Sign Up (bad user)'),
                  ),
                  Builder(builder: (context) {
                    if (ref.read(authProvider).isLoading) {
                      return const SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(),
                      );
                    }

                    return TextButton(
                      onPressed: () {
                        context.go('/');
                      },
                      child: const Text('Cancel'),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(
              height: 200,
              child: Debug(),
            ),
          ],
        ),
      ),
    );
  }
}
