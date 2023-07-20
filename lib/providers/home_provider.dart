import 'package:go_riverpod_poc/models/auth_model.dart';
import 'package:go_riverpod_poc/models/home_model.dart';
import 'package:go_riverpod_poc/providers/home_error_provider.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_provider.dart';

part 'home_provider.g.dart';

@Riverpod(keepAlive: true)
class Home extends _$Home {
  final Logger logger = Logger('HomeProvider');

  @override
  FutureOr<HomeModel?> build() async {
    logger.info('build()');
    final auth = await ref.watch(authProvider.future);

    if (auth.authState == AuthState.loggedIn) {
      logger.info('logged in => getting home');
      await Future.delayed(const Duration(seconds: 2));
      final homeError = ref.read(homeErrorProvider);

      if (homeError != null) {
        logger.info(homeError);
        throw homeError;
      }

      return HomeModel(name: 'Home');
    } else {
      return null;
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
