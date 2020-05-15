import 'package:digital_tasbeeh/Extra/AppbarMenu.dart';
import 'package:digital_tasbeeh/main.dart';
import 'package:flutter/material.dart';
import 'package:digital_tasbeeh/Wrapper.dart';
import '../Services/auth.dart';
import '../Services/auth.dart';
import '../main.dart';

class CustomScaffold extends StatelessWidget {
   final AuthService _auth = AuthService();
   CustomScaffold(
      {Key key, this.appbarTitle, this.body, this.indexofscreen})
      : super(key: key);
  final int indexofscreen;
  final String appbarTitle;
  final Widget body;


  @override
  Widget build(BuildContext context) {
       choiceAction(String choice) async{
       
    if(choice==MyMenu.profile){
    
    await _auth.gsignOut().whenComplete(() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Wrapper(
          )));
    });
    
    }
  }
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text(appbarTitle),
        leading: indexofscreen == 2
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                  
                })
            : null,
            actions:indexofscreen !=0 ? <Widget>[
              PopupMenuButton<String>(

                onSelected: choiceAction,
                itemBuilder: (BuildContext buildcontext){
                  return MyMenu.choices.map((String choice ) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                })
            ]:null
      ),
      body: body,
      
    );
  }
  navigate(){

  }
  
}
