import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/address_provider.dart';
import 'package:go_riverpod_poc/providers/auth_provider.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:go_riverpod_poc/widgets/debug.dart';
import 'package:go_router/go_router.dart';

class CreateHomeScreen extends ConsumerStatefulWidget {
  const CreateHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CreateHomeScreenState();
}

class CreateHomeScreenState extends ConsumerState<CreateHomeScreen> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(homeProvider);

    if (home is AsyncError) {
      Future.delayed(const Duration(milliseconds: 0), () {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text('Home Error'),
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

                          /// set the address in the address provider (for later submission)
                          ref
                              .read(addressProvider.notifier)
                              .setAddress(textEditingController.text);

                          /// get the home from the home provider
                          final home = ref.read(homeProvider);

                          /// if the home has an error, we've been here before and we're
                          /// trying again, so call fetch home again (will use updated address)
                          if (home.hasError) {
                            await ref.read(homeProvider.notifier).createHome();
                          }
                        },
                        child: const Text('Submit Address'),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      TextButton(
                        onPressed: () async {
                          await ref.read(authProvider.notifier).logout();
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
