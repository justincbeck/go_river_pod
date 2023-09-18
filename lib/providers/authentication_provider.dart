import 'package:go_riverpod_poc/helpers/utils.dart';
import 'package:go_riverpod_poc/models/error_model.dart';
import 'package:go_riverpod_poc/providers/user_provider.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_provider.g.dart';

@Riverpod(keepAlive: true)
class Authentication extends _$Authentication {
  final logger = Logger('AuthenticationProvider');

  @override
  FutureOr<AuthenticationState> build() {
    logger.info('build()');
    return AuthenticationState.loggedOut;
  }

  void setAuthenticationState(AuthenticationState authState) {
    logger.info('setAuthenticationState()');
    state = AsyncValue.data(authState);
  }

  Future<void> login(String username) async {
    logger.info('login()');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(Duration(milliseconds: getFakeMillis()));
      if (['bill', 'frank'].contains(username.toLowerCase())) {
        ref.read(userProvider.notifier).setUser(username);
        return AuthenticationState.loggedIn;
      }

      final authError = ErrorModel(message: 'Invalid username');
      logger.shout(authError);
      throw authError;
    });
  }

  Future<void> signUp(String username) async {
    logger.info('signUp()');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(Duration(milliseconds: getFakeMillis()));
      if (['bill', 'frank'].contains(username.toLowerCase())) {
        return AuthenticationState.signingUp;
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
      return Future.value(AuthenticationState.loggedOut);
    });
  }

  void reset() {
    ref.invalidateSelf();
  }
}

enum AuthenticationState {
  signingUp,
  signedUp,
  loggingIn,
  loggedIn,
  loggingOut,
  loggedOut,
}
