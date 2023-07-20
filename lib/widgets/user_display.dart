import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/user_provider.dart';

class UserDisplay extends ConsumerWidget {
  const UserDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Builder(builder: (context) {
      if (user is AsyncError) {
        return Text(user.error.toString());
      }
      if (user is AsyncLoading) {
        return const CircularProgressIndicator();
      }
      return Text(user.value?.name ?? 'No User');
    });
  }
}
