import 'package:go_riverpod_poc/providers/address_provider.dart';
import 'package:go_riverpod_poc/providers/authentication_provider.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authorization_provider.g.dart';

@Riverpod(keepAlive: true)
class Authorization extends _$Authorization {
  @override
  FutureOr<AuthorizationState> build() {
    final address = ref.watch(addressProvider);
    final home = ref.watch(homeProvider);
    final auth = ref.watch(authenticationProvider);

    if (home.isLoading || auth.isLoading) return AuthorizationState.loading;

    if (auth.requireValue == AuthenticationState.signingUp) {
      if (address == null && home.value == null) {
        return AuthorizationState.signingUpWithoutHome;
      }

      return AuthorizationState.signingUp;
    }

    if (auth.requireValue == AuthenticationState.loggingIn) {
      return AuthorizationState.authenticating;
    }

    if (auth.requireValue == AuthenticationState.signedUp) {
      if ((address == null && home.value == null) || home.hasError) {
        return AuthorizationState.signingUpWithoutHome;
      }

      return AuthorizationState.authorized;
    }

    if (auth.requireValue == AuthenticationState.loggedIn) {
      if ((address == null && home.value == null) || home.hasError) {
        return AuthorizationState.authenticatedWithoutHome;
      }

      return AuthorizationState.authorized;
    }

    return AuthorizationState.unauthorized;
  }

  void reset() {
    ref.invalidateSelf();
  }
}

enum AuthorizationState {
  signingUp,
  signingUpWithoutHome,
  authenticating,
  authenticatedWithoutHome,
  unauthorized,
  authorized,
  loading,
}
