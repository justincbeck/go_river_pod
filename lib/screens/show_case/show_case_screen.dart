import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/show_case_provider.dart';
import 'package:go_riverpod_poc/screens/show_case/show_case_content.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowCaseScreen extends ConsumerStatefulWidget {
  const ShowCaseScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ShowCaseScreenState();
}

class ShowCaseScreenState extends ConsumerState<ShowCaseScreen> {
  late List<GlobalKey> _stepKeys;

  @override
  void initState() {
    super.initState();
    _stepKeys = List.generate(3, (index) => GlobalKey());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ShowCaseWidget.of(context).startShowCase(_stepKeys);
    });
  }

  nextStep() {
    final step = ref.read(showCaseContentStepProvider);
    if (step >= _stepKeys.length - 1) {
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
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 80.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Showcase.withWidget(
                      onTargetClick: () => nextStep(),
                      onBarrierClick: () => nextStep(),
                      disposeOnTap: false,
                      key: e,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      tooltipPosition: TooltipPosition.bottom,
                      targetPadding: const EdgeInsets.all(8),
                      container: Container(
                        width: MediaQuery.of(context).size.width - 32,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: ShowCaseContent(
                            index: i,
                            title:
                                'Provider Step: ${ref.read(showCaseContentStepProvider)}',
                          ),
                        ),
                      ),
                      child: Text('Note $i'),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
