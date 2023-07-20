import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_error_provider.g.dart';

@Riverpod(keepAlive: true)
class HomeError extends _$HomeError {
  final logger = Logger('HomeErrorProvider');

  @override
  ErrorModel? build() {
    logger.info('build()');
    return null;
  }

  void setError(ErrorModel errorModel) {
    logger.info('setError($errorModel)');
    state = errorModel;
  }

  void reset() {
    state = null;
  }
}

class ErrorModel extends Object {
  final String message;

  ErrorModel({required this.message});

  @override
  String toString() => message;
}
