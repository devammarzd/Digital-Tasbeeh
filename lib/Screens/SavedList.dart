import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_tasbeeh/CustomWidgets/CustomScaffold.dart';
import 'package:digital_tasbeeh/Screens/TasbeehCounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/User.dart';

class SavedList extends StatefulWidget {
 
  
  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
   void ammar(){
    print('');
    // Navigator.of(context).
   }
  final db = Firestore.instance;
  String zikrContinue;
  int counterContinue;
  String id;
  // Future fetchSavedZikrs() async {
  //   var firestore = Firestore.instance;
  //   QuerySnapshot qn = await firestore.collection("Dummy").getDocuments();
  //   return qn.documents;
  // }

  Card buildItem(DocumentSnapshot doc,String name) {
    return Card(
      shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(15.0),
  side: BorderSide(color: Colors.indigo)
),
      
        color: Colors.white,
        child: Column(children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(
              top: 8.0,
              left: 12.0,
              right: 12.0,
            ),
            title: Text(
              '${doc.data['Zikr']}',
              style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600),
            ),
            trailing: Container(
              color: Colors.transparent,
              child: Text(
                '${doc.data['Count']}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                OutlineButton(
                  borderSide: BorderSide(
                    color: Colors.green[300],
                    width: 2.0,
                  ),
                  onPressed: () {
                    readData(doc,name);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Continue  ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      Icon(
                        Icons.play_circle_filled,
                        color: Colors.green[600],
                      ),
                    ],
                  ),
                  textColor: Colors.green[800],
                  highlightColor: Colors.green[100],
                  highlightedBorderColor: Colors.green[500],
                ),
                SizedBox(
                  width: 10,
                ),
                OutlineButton(
                  borderSide: BorderSide(
                    color: Colors.red[300],
                    width: 2.0,
                  ),
                  onPressed: () {
                    deleteData(doc,name);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Delete  ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      Icon(
                        Icons.delete,
                        color: Colors.red[700],
                      ),
                    ],
                  ),
                  textColor: Colors.red[800],
                  highlightColor: Colors.red[100],
                  highlightedBorderColor: Colors.red[500],
                )
              ],
            ),
          )
        ]));
  }

  void deleteData(DocumentSnapshot doc,String email) async {
    await db.collection(email).document(doc.documentID).delete();
  }

  void readData(DocumentSnapshot doc,String email) async {
    DocumentSnapshot snapshot =
        await db.collection(email).document(doc.documentID).get();
    setState(() {
      zikrContinue = snapshot.data['Zikr'];
      counterContinue = int.parse(snapshot.data['Count']);
      id = doc.documentID;
    });
    print(zikrContinue);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => TasbeehScreen(
            zikrContinue: zikrContinue,
            counterContinue: counterContinue,
            zikrID: id)));
  }

  @override
  Widget build(BuildContext context) {
      final user = Provider.of<User>(context);
      if(user!=null){
        
      
    return CustomScaffold(
      indexofscreen: 2,
      appbarTitle: 'My Saved Zikrs',
      body:
       Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: db.collection(user.email).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        children: snapshot.data.documents
                            .map((doc) => buildItem(doc, user.email))
                            .toList()),
                  );
                } else {
                  return SizedBox();
                }
              }),
        ),
      ),
    );
      }
      else {
        return CustomScaffold(
          appbarTitle: 'My Saved Zikrs',
          indexofscreen: 2,
          body: Center(child: 
          Container(child: Text('Loading...')
          ),
          ),
        );
      }
  }
}
