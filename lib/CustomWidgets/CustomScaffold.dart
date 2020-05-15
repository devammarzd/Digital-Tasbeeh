import 'package:digital_tasbeeh/Extra/AppbarMenu.dart';
import 'package:digital_tasbeeh/main.dart';
import 'package:flutter/material.dart';
import 'package:digital_tasbeeh/Wrapper.dart';
import '../Services/auth.dart';
import '../Services/auth.dart';
import '../main.dart';
import 'package:digital_tasbeeh/Screens/Profile.dart';

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
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfileScreen()));
    // await _auth.gsignOut().whenComplete(() {
    //   Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => ProfileScreen()));
    // });
    
    }
  }
  if(indexofscreen==1||indexofscreen== 2){
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
            
            actions: <Widget>[
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
            ]
      ),
      body: body,
      
    );
  }
  else{
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text(appbarTitle),
       
            
           
      ),
      body: body,
      
    );
  }
   
  }
  navigate(){

  }
  
}
