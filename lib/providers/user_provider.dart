import 'package:go_riverpod_poc/helpers/utils.dart';
import 'package:go_riverpod_poc/models/error_model.dart';
import 'package:go_riverpod_poc/models/user_model.dart';
import 'package:go_riverpod_poc/providers/authentication_provider.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class User extends _$User {
  final Logger logger = Logger('UserProvider');

  @override
  FutureOr<UserModel?> build() async {
    /// build is triggered based on changes
    /// happening in the auth provider
    logger.info('build()');
    return ref.watch(authenticationProvider).when(
          data: (auth) {
            if (auth == AuthenticationState.loggedIn) {
              return _fetchUser();
            }

            return null;
          },
          error: (error, stack) => null,
          loading: () => null,
        );
  }

  void setUser(String name) {
    logger.info('setUser($name)');
    state = AsyncValue.data(UserModel(name: name));
  }

  FutureOr<void> fetchUser() async {
    logger.info('fetchUser()');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _fetchUser();
    });
  }

  FutureOr<UserModel?> _fetchUser() async {
    await Future.delayed(Duration(milliseconds: getFakeMillis()));
    final auth = ref.read(authenticationProvider);
    if ([AuthenticationState.loggedIn, AuthenticationState.signingUp]
        .contains(auth.value)) {
      return Future.value(state.value);
    }

    final userError = ErrorModel(message: 'Not authenticated');
    logger.shout(userError);
    ref.invalidateSelf();
    throw userError;
  }

  void reset() {
    ref.invalidateSelf();
  }
}
