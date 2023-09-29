import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowCaseContent extends ConsumerWidget {
  final BuildContext targetContext;
  final String title;
  final Widget content;
  final String rightButtonTitle;
  const ShowCaseContent({
    super.key,
    required this.targetContext,
    required this.title,
    required this.content,
    required this.rightButtonTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500),
              ),
            ),
            content,
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  ShowCaseWidget.of(targetContext).previous();
                },
                child: const Row(
                  children: [
                    Icon(Icons.chevron_left_rounded),
                    Text('Previous')
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    ShowCaseWidget.of(targetContext).next();
                  },
                  child: Row(
                    children: [
                      Text(rightButtonTitle),
                      const Icon(Icons.chevron_right_rounded),
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
