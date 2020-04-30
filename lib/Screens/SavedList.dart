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
        child: Column(children: <Widget>[
      ListTile(
        title: Text('${doc.data['Zikr']}'),
        trailing: Text('${doc.data['Count']}'),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.play_circle_outline),
              iconSize: 40,
              color: Colors.green[600],
              onPressed: () {
                readData(doc);
              }),
          IconButton(
              icon: Icon(Icons.delete_forever),
              color: Colors.red,
              iconSize: 40,
              onPressed: () {
                deleteData(doc);
              })
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
