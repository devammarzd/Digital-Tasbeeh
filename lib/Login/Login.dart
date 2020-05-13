import 'package:digital_tasbeeh/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_tasbeeh/CustomWidgets/CustomScaffold.dart';
import 'package:digital_tasbeeh/CustomWidgets/custombutton.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appbarTitle: 'Login',
      indexofscreen: 0,
      body: Center(
child: RaisedButton(onPressed: (){},
color:Colors.red[700],
child: Padding(
  padding: const EdgeInsets.all(15.0),
  child:   Text('Sign in with Google', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
),

),

      ),
    );
  }
}