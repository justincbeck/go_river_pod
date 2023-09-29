import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/show_case_provider.dart';
import 'package:go_riverpod_poc/widgets/showcase.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowCaseScreen extends ConsumerStatefulWidget {
  const ShowCaseScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ShowCaseScreenState();
}

class ShowCaseScreenState extends ConsumerState<ShowCaseScreen> {
  final maxStepKeys = 5;
  late List<GlobalKey> _stepKeys;

  @override
  void initState() {
    super.initState();
    _stepKeys = List.generate(5, (index) => GlobalKey());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ShowCaseWidget.of(context).startShowCase(_stepKeys);
    });
  }

  nextStep() {
    final step = ref.read(showCaseContentStepProvider);
    if (step >= maxStepKeys - 1) {
      ShowCaseWidget.of(context).dismiss();
      ref.read(showCaseContentStepProvider.notifier).reset();
    } else {
      ref.read(showCaseContentStepProvider.notifier).nextStep();
      ShowCaseWidget.of(context).next();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(showCaseContentStepProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: () {
          ShowCaseWidget.of(context).startShowCase(_stepKeys);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _stepKeys.map(
            (e) {
              int i = _stepKeys.indexOf(e);
              if (i < maxStepKeys) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 80.0),
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: ShowcaseWidget(
                      identifier: e,
                      title: 'Note $i',
                      content: const SizedBox.shrink(),
                      child: Text('Note $i'),
                      nextCallback: () => nextStep(),
                      previousCallback: () => nextStep(),
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 80.0),
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Text('Note $i'),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
