import 'package:go_riverpod_poc/models/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'go_riverpod.g.dart';

@Riverpod(keepAlive: true)
class GoRiverpod extends _$GoRiverpod {
  @override
  FutureOr<Auth> build() {
    return Auth(authState: AuthState.loggedOut);
  }

  Future<void> login() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 2));
      return Future.value(Auth(authState: AuthState.loggedIn));
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 2));
      return Future.value(Auth(authState: AuthState.loggedOut));
    });
  }
}
