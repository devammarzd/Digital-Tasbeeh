import 'package:digital_tasbeeh/CustomWidgets/custombutton.dart';
import 'package:digital_tasbeeh/Extra/MySnackbars.dart';
import 'package:digital_tasbeeh/Screens/SavedList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_tasbeeh/CustomWidgets/CustomScaffold.dart';
import 'package:provider/provider.dart';

import '../Services/User.dart';

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
    if (counterContinue > 0)
      return setState(() {
        counterContinue--;
      });
  }

  void save(BuildContext contextforSnackbar,String email) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref = await db
          .collection(email)
          .add({'Zikr': '$zikr', 'Count': '$counterContinue'}).whenComplete(() {
        setState(() {
          zikrSaved = true;
          zikr = '';
          counterContinue = 0;
        });
        MySnackbars().saveSnackbar();
        Scaffold.of(contextforSnackbar)
            .showSnackBar(MySnackbars().saveSnackbar());
      });

      id = ref.documentID;
      print('added ' + id);
      Navigator.of(context).pop();
    }
  }

  void saveagain(BuildContext contextforSnackbar,String email) async {
    await db
        .collection(email)
        .document(zikrID)
        .updateData({'Count': '$counterContinue'}).whenComplete(() {
      MySnackbars().updateSnackbar();
      Scaffold.of(contextforSnackbar)
          .showSnackBar(MySnackbars().updateSnackbar());
    });
    print('updated to ' + zikrID);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user!=null){
    
    
    return CustomScaffold(
        indexofscreen: 1,
        appbarTitle: 'Digital Tasbeeh',
        body: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                //SAVED ZIKAR BUTTON
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: <Widget>[
                   
                //   ],
                // ),

                SizedBox(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                ),

                Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          '$zikrContinue',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.green[900],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.indigo[900],
                              width: 2.0,
                            )),
                        alignment: Alignment.center,
                        height: 80.0,
                        width: 150,
                        child: Text(
                          '$counterContinue',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.green[900],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
 //Increament Button
                      Container(
                        width: 100,
                        height: 100.0,
                        child: new RawMaterialButton(
                          fillColor: Colors.green[900],
                          highlightColor: Colors.green[200],
                          // focusColor: Colors.green[700],
                          splashColor: Colors.green[300],
                          shape: new CircleBorder(),
                          elevation: 15.0,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 80,
                          ),
                          onPressed: () {
                            _incrementCounter();
                            HapticFeedback.lightImpact();
                          },
                        ),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                      ),

//RESET BUTTON
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CustomButton(
                            buttontext: 'RESET',
                            icons: Icons.refresh,
                            onPressed: () {
                              createConfirmDialogue(context);
                            },
                          ),

//SAVE BUTTON
                          buildSaveButton(
                              context,user.email), //context is passed for building a snackbar only
                        ],
                      ),
                      SizedBox(height: 20,),
                       Padding(
                         padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                         child: CustomButton(
                      bgColor: Colors.grey,
                      buttontext: 'VIEW SAVED ZIKRS',
                      icons: Icons.view_headline,
                      onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => SavedList()));
                      },
                    ),
                       ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
    
  }
}
  
//to create a save dialog box
  createSaveDialogue(BuildContext contextforSnackbar,String email) {
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
                    save(contextforSnackbar, email);
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

  createConfirmDialogue(BuildContext context) {
    //a confirmation dialogue to pop up when the user resets the counter
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Reset the counter'),
            content: Text('Are you sure you want to reset the counter to 0?'),
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

  CustomButton buildSaveButton(BuildContext contextforSnackbar,String email) {
    if (zikrID == '') {
      return CustomButton(
        buttontext: 'SAVE ZIKR',
        icons: Icons.save,
        onPressed: () {
          createSaveDialogue(contextforSnackbar,email);
        },
      );
    } else {
      return CustomButton(
          buttontext: 'SAVE AGAIN',
          icons: Icons.save,
          onPressed: () {
            saveagain(contextforSnackbar,email);
          });
    }
  }
}
