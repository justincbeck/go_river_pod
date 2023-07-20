import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_error_provider.g.dart';

@Riverpod(keepAlive: true)
class UserError extends _$UserError {
  final logger = Logger('UserErrorProvider');

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
