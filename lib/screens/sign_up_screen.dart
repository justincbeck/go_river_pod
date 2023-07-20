import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/models/error_model.dart';
import 'package:go_riverpod_poc/providers/auth_provider.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:go_riverpod_poc/providers/user_error_provider.dart';
import 'package:go_riverpod_poc/providers/user_provider.dart';
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
    final user = ref.watch(userProvider);

    if (user.hasError) {
      Future.delayed(const Duration(milliseconds: 0), () {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(user.error!.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      });
    }

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
                      ref.read(userErrorProvider.notifier).reset();
                      final user = ref.read(userProvider);
                      if (user.hasError) {
                        await ref.read(userProvider.notifier).fetchUser();
                        return;
                      }
                      await ref.read(authProvider.notifier).login();
                    },
                    child: const Text('To /dashboard (success)'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      ref
                          .read(userErrorProvider.notifier)
                          .setError(ErrorModel(message: 'User: BOOM!'));
                      await ref.read(authProvider.notifier).login();
                    },
                    child: const Text('To /dashboard (error)'),
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
