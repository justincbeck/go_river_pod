import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class AuthModel with _$AuthModel {
  factory AuthModel({
    String? username,
    required AuthState authState,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, Object?> json) =>
      _$AuthModelFromJson(json);
}

enum AuthState {
  signingUp,
  loggingIn,
  loggedIn,
  loggingOut,
  loggedOut,
}
