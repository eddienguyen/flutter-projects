import 'dart:async';

import 'package:form_login/src/validators/validations.dart';

class LoginBloc {
  StreamController _usernameController = new StreamController();
  StreamController _passwordController = new StreamController();

  Stream get userStream => _usernameController.stream;
  Stream get passwordStream => _passwordController.stream;

  bool isValidInfo(String username, String password) {
    if (!Validations.isUsernameValid(username)) {
      _usernameController.sink.addError("username is invalid");
      return false;
    }
    _usernameController.sink.add('valid username');

    if (!Validations.isPasswordValid(password)) {
      _passwordController.sink
          .addError("password must longer than 6 characters");
      return false;
    }
    _passwordController.sink.add("valid password");
    return true;
  }

  // because stream is always listen
  void dispose() {
    _usernameController.close();
    _passwordController.close();
  }
}
