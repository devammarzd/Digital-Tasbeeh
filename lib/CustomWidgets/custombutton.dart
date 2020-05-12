import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key key,
      @required this.buttontext,
      @required this.icons,
      @required this.onPressed,
      this.bgColor = Colors.blueGrey})
      : super(key: key);

  final String buttontext;
  final void Function() onPressed;
  final Color bgColor;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Padding(
   padding: const EdgeInsets.all(20),
        child:
          SizedBox(
            width: MediaQuery.of(context).size.width/2.8,
               child: RaisedButton(
                 color: Colors.white54,
                 highlightColor: Colors.teal,
              onPressed: onPressed,
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
 Text(buttontext, style: TextStyle( fontSize: 15, fontWeight: FontWeight.w600)),
 Icon(icons,color: Colors.teal,),
                 ],
                 ),
            ),
          ), );

 }
    
}   
    
