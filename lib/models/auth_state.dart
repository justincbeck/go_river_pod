class AuthModel {
  final AuthState authState;

  AuthModel({required this.authState});

  @override
  String toString() {
    return authState.toString();
  }
}

enum AuthState {
  loggedIn,
  loggedOut,
}
