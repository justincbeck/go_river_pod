import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/authentication_provider.dart';
import 'package:go_riverpod_poc/widgets/debug.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final textEditingController = TextEditingController();
  bool hasShownError = false;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authenticationProvider);

    if (auth is AsyncError && !hasShownError) {
      Future.delayed(const Duration(milliseconds: 0), () {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text('User Error'),
              content: Text(auth.error.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    hasShownError = true;
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login Screen'),
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
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: textEditingController,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          /// if the text editing controller is empty, do nothing
                          if (textEditingController.text.isEmpty) return;

                          hasShownError = false;

                          /// attempt to login using the presented username
                          await ref
                              .read(authenticationProvider.notifier)
                              .login(textEditingController.text);
                        },
                        child: const Text('Submit Username'),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(authenticationProvider.notifier).logout();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
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
