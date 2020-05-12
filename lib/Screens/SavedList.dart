import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_tasbeeh/CustomWidgets/CustomScaffold.dart';
import 'package:digital_tasbeeh/Screens/TasbeehCounter.dart';
import 'package:flutter/material.dart';

class SavedList extends StatefulWidget {
  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  final db = Firestore.instance;
  String zikrContinue;
  int counterContinue;
  String id;
  // Future fetchSavedZikrs() async {
  //   var firestore = Firestore.instance;
  //   QuerySnapshot qn = await firestore.collection("Dummy").getDocuments();
  //   return qn.documents;
  // }

  Card buildItem(DocumentSnapshot doc) {
     return Card(
       
       color: Colors.teal[100],
 child: Column(children: <Widget>[
      ListTile( contentPadding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0,),
        title: Text('${doc.data['Zikr']}', style: TextStyle(fontSize: 25 , fontStyle: FontStyle.italic ),),
        trailing: Container(
          color: Colors.transparent,
          child: Text('${doc.data['Count']}', style: TextStyle(fontSize: 20,),),), 
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          OutlineButton(onPressed: () {
                readData(doc);
              },
               child: Row( children: <Widget>[
 Text("Resume  ", style: TextStyle( fontSize: 15, fontWeight: FontWeight.w600)),
 Icon(Icons.play_circle_filled,color: Colors.green[600],),
               ],
               ),
               hoverColor: Colors.teal[300],
               focusColor: Colors.teal,),

               SizedBox(
                 width: 10,
               ),

   OutlineButton(onPressed: () {  deleteData(doc); },
    child: Row( 
      children: <Widget>[
        Text("Delete  ", style: TextStyle( fontSize: 15, fontWeight: FontWeight.w600)),
        Icon(Icons.delete,color: Colors.red[700],),
        ], ),
               hoverColor: Colors.teal[300],
               focusColor: Colors.teal,),
        ],
      )
    ]));
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Dummy').document(doc.documentID).delete();
  }

  void readData(DocumentSnapshot doc) async {
    DocumentSnapshot snapshot =
        await db.collection('Dummy').document(doc.documentID).get();
    setState(() {
      zikrContinue = snapshot.data['Zikr'];
      counterContinue = int.parse(snapshot.data['Count']);
      id=doc.documentID;
    });
    print(zikrContinue);
    Navigator.of(context).pushReplacement(MaterialPageRoute(

        builder: (context) => TasbeehScreen(
              zikrContinue: zikrContinue,
              counterContinue: counterContinue,
              zikrID:id
            )));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      indexofscreen: 2,
      appbarTitle: 'My Saved Zikrs',
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: db.collection('Dummy').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                                  child: Column(
                      children: snapshot.data.documents
                          .map((doc) => buildItem(doc))
                          .toList()),
                );
              } else {
                return SizedBox();
              }
            }),
      ),
    );
  }
}