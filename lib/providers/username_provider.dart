import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'username_provider.g.dart';

@Riverpod(keepAlive: true)
class Username extends _$Username {
  @override
  String? build() {
    return null;
  }

  void setUsername(String username) {
    state = username;
  }
}
