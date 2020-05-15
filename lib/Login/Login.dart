import 'package:digital_tasbeeh/CustomWidgets/CustomScaffold.dart';

import 'package:flutter/material.dart';

import 'package:digital_tasbeeh/Services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appbarTitle: 'Login',
      indexofscreen: 0,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: RaisedButton(
                onPressed: () async {
                  await _auth.gsignIn();
                },
                color: Colors.red[700],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
