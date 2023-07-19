import 'package:go_riverpod_poc/models/user_model.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class User extends _$User {
  @override
  FutureOr<UserModel?> build() async {
    print('building user');
    final home = await ref.watch(homeProvider.future);
    if (home != null) {
      print('has home => getting user');
      await Future.delayed(const Duration(seconds: 3));
      return UserModel(name: 'Randal');
    } else {
      return null;
    }
  }
}
