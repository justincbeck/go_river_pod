class AuthModel {
  final AuthState authState;
  final String? username;

  AuthModel({
    this.username,
    required this.authState,
  });

  @override
  String toString() {
    return '$username, ${authState.toString()}';
  }
}

enum AuthState {
  loggingIn,
  signingUp,
  loggedIn,
  loggedOut,
}
