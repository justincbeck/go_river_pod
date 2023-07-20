import 'package:go_riverpod_poc/helpers/utils.dart';
import 'package:go_riverpod_poc/models/auth_model.dart';
import 'package:go_riverpod_poc/models/error_model.dart';
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

  void setSigningUp() {
    logger.info('setSigningUp()');
    state = AsyncData(AuthModel(authState: AuthState.signingUp));
  }

  Future<void> signUp(String username) async {
    logger.info('signUp()');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(Duration(milliseconds: getFakeMillis()));
      if (['bill', 'frank'].contains(username.toLowerCase())) {
        return AuthModel(
          username: username,
          authState: AuthState.signingUp,
        );
      }

      final authError = ErrorModel(message: 'Invalid username');
      logger.shout(authError);
      throw authError;
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
    ref.invalidateSelf();
  }
}
