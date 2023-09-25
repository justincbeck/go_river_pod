import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowCaseContent extends ConsumerWidget {
  final int index;
  final String title;
  const ShowCaseContent({
    super.key,
    required this.index,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        const Text('And some other junk'),
      ],
    );
  }
}
