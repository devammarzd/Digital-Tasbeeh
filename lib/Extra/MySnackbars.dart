import 'package:flutter/material.dart';

class MySnackbars {
  SnackBar saveSnackbar() {
    return SnackBar(
      duration: Duration(milliseconds: 2500),
      content: Row(
        children: <Widget>[
          Text(
            'Your Zikr has been saved!',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(110, 0, 10, 0),
              child: Icon(Icons.cloud_done))
        ],
      ),
      backgroundColor: Colors.green[800],
      elevation: 5.0,
    );
  }

  SnackBar updateSnackbar() {
    return SnackBar(
      duration: Duration(milliseconds: 2500),
      content: Row(
        children: <Widget>[
          Text(
            'Your Zikr has been updated!',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(80, 0, 0, 0),
              child: Icon(Icons.cloud_upload))
        ],
      ),
      backgroundColor: Colors.green[800],
      elevation: 5.0,
    );
  }
}
