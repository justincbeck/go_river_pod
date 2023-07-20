import 'package:go_riverpod_poc/helpers/utils.dart';
import 'package:go_riverpod_poc/models/auth_model.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  final logger = Logger('AuthProvider');

  @override
  FutureOr<AuthModel> build() {
    logger.info('build()');
    return AuthModel(authState: AuthState.loggedOut);
  }

  Future<void> login() async {
    logger.info('login()');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(Duration(milliseconds: getFakeMillis()));
      return Future.value(AuthModel(authState: AuthState.loggedIn));
    });
  }

  Future<void> logout() async {
    logger.info('logout()');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(Duration(milliseconds: getFakeMillis()));
      return Future.value(AuthModel(authState: AuthState.loggedOut));
    });
  }

  void reset() {
    state = AsyncValue.data(AuthModel(authState: AuthState.loggedOut));
  }
}
