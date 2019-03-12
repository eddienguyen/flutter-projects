import 'package:flutter/material.dart';
import 'package:form_login/src/blocs/Login_bloc.dart';
import 'package:form_login/src/pages/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = new LoginBloc();
  bool _showPass = false;
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  // var usernameErrorText = '';
  // var passwordErrorText = 'password must longer than 6 characters';
  // bool _userInvalid = false;
  // bool _passInvalid = false;

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        constraints: BoxConstraints.expand(), // expand full screen
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: Container(
                width: 70.0,
                height: 70.0,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffd8d8d8)),
                child: FlutterLogo(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: Text(
                'Hello\nWelcome back',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: StreamBuilder(
                  stream: bloc.userStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _usernameController,
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                          labelText: 'USERNAME:',
                          errorText: snapshot.hasError ? snapshot.error : null,
                          labelStyle: TextStyle(
                              color: Color(0xff888888), fontSize: 12.0)),
                    );
                  },
                )),
            Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  StreamBuilder(
                    stream: bloc.passwordStream,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _passwordController,
                        obscureText: !_showPass,
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        decoration: InputDecoration(
                            labelText: 'PASSWORD:',
                            errorText:
                                snapshot.hasError ? snapshot.error : null,
                            labelStyle: TextStyle(
                                color: Color(0xff888888), fontSize: 12.0)),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: onToggleShowPassword,
                    child: Text(
                      _showPass ? 'HIDE' : 'SHOW',
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 56.0,
              child: RaisedButton(
                elevation: 10.0,
                color: Theme.of(context).primaryColor,
                onPressed: onSignInClicked,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                child: Text(
                  'SIGN IN',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 60.0,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'NEW USER? SIGNUP',
                    style: TextStyle(color: Color(0xff888888), fontSize: 13.0),
                  ),
                  Text(
                    'FORGOT PASSWORD?',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 13.0),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  onSignInClicked() {
    setState(() {
      if (bloc.isValidInfo(
          _usernameController.text, _passwordController.text)) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  onToggleShowPassword() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  Widget goToHomeScreen(BuildContext context) {
    return HomePage();
  }
}
