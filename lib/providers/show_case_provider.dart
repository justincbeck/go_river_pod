import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'show_case_provider.g.dart';

@Riverpod(keepAlive: true)
class ShowCaseContentStep extends _$ShowCaseContentStep {
  @override
  int build() {
    return 0;
  }

  void nextStep() {
    state = state + 1;
  }

  void reset() {
    ref.invalidateSelf();
  }
}
