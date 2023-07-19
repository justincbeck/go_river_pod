import 'package:go_riverpod_poc/models/auth_state.dart';
import 'package:go_riverpod_poc/models/home_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_provider.dart';

part 'home_provider.g.dart';

@Riverpod(keepAlive: true)
class Home extends _$Home {
  @override
  FutureOr<HomeModel?> build() async {
    print('building home');
    final auth = await ref.watch(authProvider.future);
    if (auth.authState == AuthState.loggedIn) {
      print('logged in => getting home');
      await Future.delayed(const Duration(seconds: 2));
      return HomeModel(name: 'Home');
    } else {
      return null;
    }
  }
}
