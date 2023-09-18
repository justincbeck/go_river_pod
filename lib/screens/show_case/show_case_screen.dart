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
  final _one = GlobalKey();
  final _two = GlobalKey();
  final _three = GlobalKey();

  late List<GlobalKey> _stepKeys;

  @override
  void initState() {
    _stepKeys = [_one, _two, _three];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ShowCaseWidget.of(context).startShowCase(_stepKeys);
    });
    super.initState();
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
    final stepKeys = [_one, _two, _three];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Case Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: stepKeys.map((e) {
          int i = stepKeys.indexOf(e);
          return Row(
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
                      title:
                          'Provider Step: ${ref.read(showCaseContentStepProvider)}',
                    ),
                  ),
                ),
                child: Text('Note $i'),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
