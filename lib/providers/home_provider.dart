import 'package:go_riverpod_poc/helpers/utils.dart';
import 'package:go_riverpod_poc/models/error_model.dart';
import 'package:go_riverpod_poc/models/home_model.dart';
import 'package:go_riverpod_poc/providers/address_provider.dart';
import 'package:go_riverpod_poc/providers/authentication_provider.dart';
import 'package:go_riverpod_poc/providers/smarty_provider.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.g.dart';

@Riverpod(keepAlive: true)
class Home extends _$Home {
  final Logger logger = Logger('HomeProvider');

  @override
  FutureOr<HomeModel?> build() async {
    /// build is triggered based on changes
    /// happening in the auth provider
    logger.info('build()');
    return ref.watch(authenticationProvider).when(
          data: (auth) {
            final manualAddress = ref.read(addressProvider);
            final smarty = ref.read(smartyProvider).value;
            final address = smarty?.toSmartySuggestionString() ?? manualAddress;
            if (auth == AuthenticationState.signedUp && address != null) {
              return _createHome();
            } else if (auth == AuthenticationState.loggedIn) {
              if (state.hasValue && state.value is HomeModel) {
                return state.value;
              }

              return _fetchHome();
            }
            return null;
          },
          error: (error, stack) => null,
          loading: () => null,
        );
  }

  FutureOr<void> createHome() async {
    logger.info('createHome()');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _createHome();
    });
  }

  FutureOr<HomeModel?> _createHome() async {
    await Future.delayed(Duration(milliseconds: getFakeMillis()));
    final manualAddress = ref.read(addressProvider);
    final smarty = ref.read(smartyProvider).value;
    final address = smarty?.toSmartySuggestionString() ?? manualAddress;

    if (address != null && address.toLowerCase().contains('123 cherry ave')) {
      ref.read(smartyProvider.notifier).reset();
      ref.read(addressProvider.notifier).reset();
      return Future.value(HomeModel(name: address));
    }

    final homeError = ErrorModel(message: 'Invalid address');
    logger.shout(homeError);
    throw homeError;
  }

  FutureOr<HomeModel?> _fetchHome() async {
    await Future.delayed(Duration(milliseconds: getFakeMillis()));
    return Future.value(HomeModel(name: '123 Cherry Ave Altoona, PA'));
  }

  void reset() {
    ref.invalidateSelf();
  }
}
