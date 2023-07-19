class Auth {
  final AuthState authState;

  Auth({required this.authState});
}

enum AuthState {
  loggedIn,
  loggedOut,
}
