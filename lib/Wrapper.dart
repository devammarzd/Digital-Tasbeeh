import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Login/Login.dart';
import 'Screens/TasbeehCounter.dart';
import 'Services/User.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
if(user!=  null){
print('fetched id : '+user.uid);
print('fetched email : '+user.email);
}

    if (user == null) {
      return LoginScreen();
    } else {
      return TasbeehScreen(zikrContinue: 'New Zikr',counterContinue: 0,zikrID: '',);;
    
    }
  }
}
