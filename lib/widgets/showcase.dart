import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/screens/show_case/show_case_content.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowcaseWidget extends ConsumerWidget {
  final GlobalKey identifier;
  final Widget child;
  final String title;
  final Widget content;
  final String? rightButtonTitle;
  final VoidCallback? nextCallback;
  final VoidCallback? previousCallback;
  const ShowcaseWidget({
    super.key,
    required this.identifier,
    required this.child,
    required this.title,
    required this.content,
    this.rightButtonTitle,
    this.nextCallback,
    this.previousCallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Showcase.withWidget(
      onTargetClick: () => nextCallback?.call(),
      onBarrierClick: () => nextCallback?.call(),
      disposeOnTap: false,
      key: identifier,
      height: 200,
      width: MediaQuery.of(context).size.width,
      tooltipPosition:
          getTooltipPositon(identifier, MediaQuery.of(context).size.height),
      targetPadding: const EdgeInsets.all(8),
      container: Container(
        width: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ShowCaseContent(
            targetContext: context,
            title: title,
            content: content,
            rightButtonTitle: rightButtonTitle ?? 'Next',
          ),
        ),
      ),
      child: child,
    );
  }

  TooltipPosition getTooltipPositon(GlobalKey key, double height) {
    var tooltipPosition = TooltipPosition.bottom;
    final box = key.currentContext?.findRenderObject() as RenderBox?;
    final position = box?.localToGlobal(Offset.zero);
    double? y = position?.dy;
    if (y != null && y > height / 1.5) {
      tooltipPosition = TooltipPosition.top;
    }

    return tooltipPosition;
  }
}
