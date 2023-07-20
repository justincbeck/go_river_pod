import 'package:go_riverpod_poc/helpers/utils.dart';
import 'package:go_riverpod_poc/models/auth_model.dart';
import 'package:go_riverpod_poc/models/error_model.dart';
import 'package:go_riverpod_poc/models/home_model.dart';
import 'package:go_riverpod_poc/providers/address_provider.dart';
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
    return ref.watch(authProvider).when(
          data: (auth) {
            final address = ref.read(addressProvider);
            if (auth.authState == AuthState.signingUp && address != null) {
              return _createHome();
            }
            return null;
          },
          error: (error, stack) => null,
          loading: () => null,
        );
  }

  FutureOr<void> createHome() async {
    logger.info('fetchHome()');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _createHome();
    });
  }

  FutureOr<HomeModel?> _createHome() async {
    await Future.delayed(Duration(milliseconds: getFakeMillis()));
    final address = ref.read(addressProvider);
    if (address?.toLowerCase() == '123 cherry ave') {
      ref.read(addressProvider.notifier).reset();
      return Future.value(HomeModel(name: address!));
    }

    final homeError = ErrorModel(message: 'Invalid address');
    logger.shout(homeError);
    throw homeError;
  }

  void reset() {
    ref.invalidateSelf();
  }
}
