import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/address_provider.dart';
import 'package:go_riverpod_poc/providers/authentication_provider.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:go_riverpod_poc/providers/smarty_provider.dart';
import 'package:go_riverpod_poc/widgets/debug.dart';
import 'package:go_riverpod_poc/widgets/smarty_search/smarty_search.dart';
import 'package:go_router/go_router.dart';

class EnterAddressScreen extends ConsumerStatefulWidget {
  const EnterAddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EnterAddressScreenState();
}

class _EnterAddressScreenState extends ConsumerState<EnterAddressScreen> {
  final textEditingController = TextEditingController();
  bool hasShownError = false;

  @override
  void initState() {
    textEditingController.text = ref.read(addressProvider) ?? '';
    ref.read(smartyProvider.notifier).reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(homeProvider);

    if (home is AsyncError && !hasShownError) {
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

    return WillPopScope(
      onWillPop: () {
        ref.read(addressProvider.notifier).reset();
        ref.read(smartyProvider.notifier).reset();
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                      child: SmartySearch(
                        textEditingController: textEditingController,
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

                            /// set the address in the address provider (for later submission)
                            ref
                                .read(addressProvider.notifier)
                                .setAddress(textEditingController.text);

                            /// get the home from the home provider so we can see if
                            /// this is a do-over or if this is our first time here
                            final home = ref.read(homeProvider);

                            /// if the home has an error, we've been here before and we're
                            /// trying again, so call fetch home again (will use updated address)
                            if (home.hasError) {
                              await ref
                                  .read(homeProvider.notifier)
                                  .createHome();
                            }
                          },
                          child: const Text('Submit Address'),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        TextButton(
                          onPressed: () async {
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
