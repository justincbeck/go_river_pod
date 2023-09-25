import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/address_provider.dart';
import 'package:go_riverpod_poc/providers/authentication_provider.dart';
import 'package:go_riverpod_poc/providers/user_provider.dart';
import 'package:go_riverpod_poc/widgets/debug.dart';
import 'package:go_riverpod_poc/widgets/user_display.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DashboardScreenState();
}

class DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(userProvider.notifier).fetchUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(authenticationProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const UserDisplay(),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    ref.read(addressProvider.notifier).reset();
                    await ref.read(authenticationProvider.notifier).logout();
                  },
                  child: const Text('Logout'),
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
    );
  }
}
