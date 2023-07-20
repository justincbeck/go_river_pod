import 'package:go_riverpod_poc/helpers/utils.dart';
import 'package:go_riverpod_poc/models/auth_model.dart';
import 'package:go_riverpod_poc/models/user_model.dart';
import 'package:go_riverpod_poc/providers/auth_provider.dart';
import 'package:go_riverpod_poc/providers/user_error_provider.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class User extends _$User {
  final Logger logger = Logger('UserProvider');

  @override
  FutureOr<UserModel?> build() async {
    logger.info('build()');
    final auth = await ref.watch(authProvider.future);

    if (auth.authState == AuthState.loggedIn) {
      logger.info('logged in => getting user');
      await fetchUser();
      return state.value;
    } else {
      return null;
    }
  }

  FutureOr<void> fetchUser() async {
    state = const AsyncValue.loading();

    final userError = ref.read(userErrorProvider);
    if (userError != null) {
      logger.info(userError);
      throw userError;
    }

    await Future.delayed(Duration(milliseconds: getFakeMillis()));
    state = AsyncValue.data(UserModel(name: 'Randal'));
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
