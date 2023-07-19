import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_error_provider.g.dart';

@Riverpod(keepAlive: true)
class HomeError extends _$HomeError {
  @override
  ErrorModel? build() {
    return null;
  }

  void setError(ErrorModel errorModel) {
    state = errorModel;
  }
}

class ErrorModel extends Object {
  final String message;

  ErrorModel({required this.message});

  @override
  String toString() => message;
}
