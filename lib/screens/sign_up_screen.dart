import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/address_provider.dart';
import 'package:go_riverpod_poc/providers/authentication_provider.dart';
import 'package:go_riverpod_poc/providers/smarty_provider.dart';
import 'package:go_riverpod_poc/widgets/debug.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SignUpScreenState();
}

class SignUpScreenState extends ConsumerState<SignUpScreen> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authenticationProvider);

    if (auth is AsyncError) {
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

    return WillPopScope(
      onWillPop: () {
        ref.read(addressProvider.notifier).reset();
        ref.read(smartyProvider.notifier).reset();
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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

                            /// attempt to login using the presented username
                            await ref
                                .read(authenticationProvider.notifier)
                                .signUp(textEditingController.text);
                          },
                          child: const Text('Submit Username'),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        TextButton(
                          onPressed: () {
                            ref.read(addressProvider.notifier).reset();
                            ref.read(smartyProvider.notifier).reset();
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
      ),
    );
  }
}
