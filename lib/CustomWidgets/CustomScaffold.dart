
import 'package:digital_tasbeeh/main.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {Key key, this.appbarTitle, this.body, this.indexofscreen})
      : super(key: key);
  final int indexofscreen;
  final String appbarTitle;
  final Widget body;
  @override
  Widget build(BuildContext context) {

    // for background image
    return Stack(
        children: <Widget>[
          Image.asset('images\background.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
          //backgroundColor: Colors.teal[200],
          appBar: AppBar(
            
            centerTitle: true,
            title: Text(appbarTitle),
            leading: indexofscreen == 2
                ? IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
 Navigator.pushReplacement(context,
  MaterialPageRoute(builder: (context) => MyHomePage()));}) : null,
 ),
         
   body: body, 
), ], );
      
  }
}
