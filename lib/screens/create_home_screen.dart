import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/models/error_model.dart';
import 'package:go_riverpod_poc/providers/home_error_provider.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:go_riverpod_poc/widgets/debug.dart';
import 'package:go_router/go_router.dart';

class CreateHomeScreen extends ConsumerWidget {
  const CreateHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final home = ref.watch(homeProvider);

    if (home.hasError) {
      Future.delayed(const Duration(milliseconds: 0), () {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(home.error!.toString()),
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
        title: const Text('Create Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      ref.read(homeErrorProvider.notifier).reset();
                      final home = ref.read(homeProvider);
                      if (home.hasError) {
                        await ref.read(homeProvider.notifier).fetchHome();
                        return;
                      }
                      context.go('/sign_up');
                    },
                    child: const Text('To /sign_up (success)'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(homeErrorProvider.notifier)
                          .setError(ErrorModel(message: 'BOOM!'));
                      context.go('/sign_up');
                    },
                    child: const Text('To /sign_up (error)'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/');
                    },
                    child: const Text('Cancel'),
                  ),
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
