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
            children: <Widget>[
               Text(
                '$zikrContinue',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.green[700],
                )
                ),
              Text(
                '$counterContinue',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.green[700],
                  
                ),
              ),
              FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
              RaisedButton(
                onPressed: () {
                  createConfirmDialogue(context);
                },
                child: Text('Reset'),
              ),
              buildSaveButton(
                  context), //context is passed for building a snackbar only
              RaisedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SavedList()));
                },
                child: Text('View Saved Zikrs'),
              ),
            ],
          );
        }));
  }

  createSaveDialogue(BuildContext contextforSnackbar) {//to create a save dialogue box
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
                Text('Are you sure you want to reset the counter to zero?'),
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

  RaisedButton buildSaveButton(BuildContext contextforSnackbar) {
    if (zikrID == '') {
      return RaisedButton(
        onPressed: () {
          createSaveDialogue(contextforSnackbar);
        },
        child: Text('Save'),
      );
    } else {
      return RaisedButton(
        onPressed: () {
          saveagain(contextforSnackbar);
        },
        child: Text('Save Again'),
      );
    }
  }
}
