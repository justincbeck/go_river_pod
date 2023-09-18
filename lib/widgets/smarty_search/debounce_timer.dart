import 'dart:async';

const Duration debounceDuration = Duration(milliseconds: 300);

class DebounceTimer {
  DebounceTimer() {
    _timer = Timer(debounceDuration, _onComplete);
  }

  late final Timer _timer;
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError(const CancelException());
  }
}

// An exception indicating that the timer was canceled.
class CancelException implements Exception {
  const CancelException();
}
