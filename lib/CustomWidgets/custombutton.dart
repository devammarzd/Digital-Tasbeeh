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
    return RaisedButton(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(20.0),
  side: BorderSide(color: Colors.indigo)
),
      color: Colors.white,
      highlightColor: Colors.indigo[200],
      
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row( 
            
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     children: <Widget>[
 Text(buttontext, style: TextStyle( fontSize: 16, fontWeight: FontWeight.w600,color: Colors.indigo)),
 SizedBox(width:15 ,),
 Icon(icons,color: Colors.indigo,),
      ],
      ),
        ),
      );

 }
    
}   
    
