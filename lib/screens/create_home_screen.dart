import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/home_error_provider.dart';
import 'package:go_router/go_router.dart';

class CreateHomeScreen extends ConsumerWidget {
  const CreateHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.go('/sign_up');
                    },
                    child: const Text('Next Step (success)'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(homeErrorProvider.notifier)
                          .setError(ErrorModel(message: 'Bad Home'));
                      context.go('/sign_up');
                    },
                    child: const Text('Next Step (bad home)'),
                  ),
                ],
              ),
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
    );
  }
}
