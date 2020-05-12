import 'package:digital_tasbeeh/CustomWidgets/custombutton.dart';
import 'package:digital_tasbeeh/Extra/MySnackbars.dart';
import 'package:digital_tasbeeh/Screens/SavedList.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_tasbeeh/CustomWidgets/CustomScaffold.dart';

class TasbeehScreen extends StatefulWidget {
  String zikrContinue;
  int counterContinue;
  String zikrID;
  TasbeehScreen({Key key, this.zikrContinue, this.counterContinue, this.zikrID})
      : super(key: key);
  @override
  _TasbeehScreenState createState() =>
      _TasbeehScreenState(zikrContinue, counterContinue, zikrID);
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  String zikrContinue;
  int counterContinue;
  String zikrID;
  bool zikrSaved = false;
  _TasbeehScreenState(this.zikrContinue, this.counterContinue, this.zikrID);
  String zikr;
  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();

  void _incrementCounter() {
    setState(() {
      counterContinue++;
    });
  }

  void _resetCounter() {
    setState(() {
      counterContinue = 0;
    });
  }
void _decrementCounter() {
  if (counterContinue>0)
   return setState(() {
      counterContinue--;
    });
  }


  void save(BuildContext contextforSnackbar) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref = await db
          .collection('Dummy')
          .add({'Zikr': '$zikr', 'Count': '$counterContinue'}).whenComplete(() {
        setState(() {
          zikrSaved = true;
          zikr = '';
          counterContinue = 0;
        });
        MySnackbars().saveSnackbar();
        Scaffold.of(contextforSnackbar).showSnackBar( MySnackbars().saveSnackbar());
      });

      id = ref.documentID;
      print('added ' + id);
      Navigator.of(context).pop();
    }
  }

  void saveagain(BuildContext contextforSnackbar) async {
    await db
        .collection('Dummy')
        .document(zikrID)
        .updateData({'Count': '$counterContinue'}).whenComplete(
          (){
 MySnackbars().updateSnackbar();
        Scaffold.of(contextforSnackbar).showSnackBar( MySnackbars().updateSnackbar());
          }
        );
    print('updated to ' + zikrID);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        indexofscreen: 1,
        appbarTitle: 'Digital Tasbeeh',
        body: Builder(builder: (context) {
          return ListView(
            scrollDirection: Axis.vertical,
      children:<Widget>[

        //SAVED ZIKAR BUTTON
        Padding(
        padding: EdgeInsets.only(top: 6, left: 150),
        child:
        CustomButton(
          bgColor: Colors.grey,
          buttontext: 'view saved zikr',
          icons:Icons.view_headline,
          onPressed:  () { 
       Navigator.pushReplacement(context,
       MaterialPageRoute(builder: (context) => SavedList())); },
        ),
        ),

              SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width,
              ),

              Center(
                child: Text(
                  '$zikrContinue',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black, 
                  ),
                ),
              ),
              

             
       Column(
       mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[ 

 Center(
             child: Container(
               alignment: Alignment.center,
               color: Colors.transparent,
               height: 60.0,
               width: 120,
               child: Text(
               '$counterContinue',
              style: TextStyle(
                 fontSize: 50,
                 color: Colors.teal,
                  ),),
             ),
           ),
           SizedBox(height: 20,),
 CircleAvatar(
   maxRadius: 60,

   backgroundColor: Colors.teal,
   child: IconButton(icon: Icon(Icons.add), 

   iconSize: 70,
   onPressed: _incrementCounter),
 ),

                 ],),

    SizedBox(width: MediaQuery.of(context).size.width, height: 50,),
             
              
//RESET BUTTON
 Row(
   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
   children: <Widget>[
     CustomButton(buttontext: 'RESET',
        icons: Icons.refresh,
        onPressed: () {
        createConfirmDialogue(context); },),
  


//SAVE BUTTON 
 buildSaveButton(context), //context is passed for building a snackbar only
  ],
 ),


 ],
          );
        }));
  }
//to create a save dialog box
createSaveDialogue(BuildContext contextforSnackbar) {
    return showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: _formKey,
            child: AlertDialog(
              title: Text('Save to the List'),
              content: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter the name of zikr',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter the name of Zikr';
                  } else
                    return null;
                },
                onSaved: (value) {
                  zikr = value;
                },
              ),
              actions: <Widget>[
               FlatButton(
                  onPressed: () {
                    save(contextforSnackbar);
                    //A Scaffold context is passed in save() so that we can use the scaffold context for snakbar display
                    //the context has got nothing to do with saving of item.
                  },
                  child: Text('Save'),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      zikr = null;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                )
              ],
            ),
          );
        });
  }

  createConfirmDialogue(BuildContext context) {//a confirmation dialogue to pop up when the user resets the counter
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Reset the counter'),
            content:
                Text('Are you sure you want to reset the counter to 0?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  _resetCounter();
                  Navigator.pop(context);
                },
                child: Text('Yes'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'),
              )
            ],
          );
        });
  }

  CustomButton buildSaveButton(BuildContext contextforSnackbar) {
    if (zikrID == '') {
      return CustomButton(buttontext: 'SAVE ZIKR',
      icons: Icons.save,
      onPressed: () {createSaveDialogue(contextforSnackbar); }, );
    } 
  else {
      return CustomButton(buttontext: 'SAVE AGAIN',
      icons: Icons.save,
        onPressed: () {
          saveagain(contextforSnackbar);}
          );
    }
  }
}
