import 'package:digital_tasbeeh/Login/Login.dart';
import 'package:digital_tasbeeh/Screens/TasbeehCounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_tasbeeh/Services/User.dart';

import 'Services/auth.dart';
import 'Wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
          child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.indigo,
          
          // primarySwatch: Colors.indigo,
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Wrapper();
    // return TasbeehScreen(zikrContinue: 'New Zikr',counterContinue: 0,zikrID: '',);
  }
}
