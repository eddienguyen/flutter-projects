class Validations {
  static bool isUsernameValid(String username) {
    return username != null && username.length > 6 && username.contains('@');
  }

  static bool isPasswordValid(String password) {
    return password != null && password.length > 6;
  }
}
