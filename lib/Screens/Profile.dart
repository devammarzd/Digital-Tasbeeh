import 'package:flutter/material.dart';
import 'package:digital_tasbeeh/Services/auth.dart';
import 'package:digital_tasbeeh/Services/User.dart';
import 'package:provider/provider.dart';

import '../CustomWidgets/CustomScaffold.dart';
import '../Services/auth.dart';
import '../Services/auth.dart';
import '../Wrapper.dart';
import '../main.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> litems = [
    "Full Name",
    "Email",
    "Phone Number",
  ];
  String photourl;
  String name;
  String email;
  String phonenumber = '+92xxxxxxxxxx';
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      setState(() {
        name = user.name;
        email = user.email;
        // phonenumber=user.phone;
        photourl = user.photourl;
      });

      return CustomScaffold(
          appbarTitle: 'My Profile',
          indexofscreen: 3,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Card(
                elevation: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 5),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(photourl),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(user.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(user.email,
                              style: TextStyle(
                                fontSize: 18,
                              )),
                          SizedBox(height: 10),
                          RaisedButton(
                              elevation: 8,
                              textColor: Colors.white,
                              color: Colors.red,
                              onPressed: () async {
                                await _auth.gsignOut().whenComplete(() =>
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => MyApp())));
                              },
                              child: Text('SIGN OUT',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.indigo[300],
                thickness: 3,
              ),
              Container(
                child: ListView(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        litems[0],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(name),
                    ),
                    Divider(
                      color: Colors.indigo[300],
                      thickness: 3,
                    ),
                    ListTile(
                      title: Text(
                        litems[1],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(email),
                    ),
                    Divider(
                      color: Colors.indigo[300],
                      thickness: 3,
                    ),
                    ListTile(
                      title: Text(
                        litems[2],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(phonenumber),
                    ),
                    Divider(
                      color: Colors.indigo[300],
                      thickness: 3,
                    ),
                    ListTile(
                        title: Text(
                          'Dark Theme',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Switch(
                          value: false,
                          onChanged: null,
                        ))
                  ],
                ),
              ),
            ])),
          ));
    } else {
      return CustomScaffold(
          appbarTitle: 'My Profile',
          indexofscreen: 4,
          body: Center(
              child: Container(
            child: Text('Error: User is null'),
          )));
    }
  }
}
