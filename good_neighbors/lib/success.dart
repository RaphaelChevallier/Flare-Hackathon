import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'google_maps_view.dart';

class Success extends StatelessWidget {
  var object;
  String keys;

  Success(this.object, this.keys);

  @override
  Widget build(BuildContext context) {
    updateData(keys);
        return AlertDialog(
          title: new Text("You've helped your fellow community member!!!"),
          content: new Text("Keep up the good work and get rewards and points!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Go back to map"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GetCurrentLocation()),
                );
              }
            ),
          ],
        );
}

void updateData(keys){
  DatabaseReference ref = FirebaseDatabase.instance.reference();
  ref.child('requests').child('${keys}').update({
    'resolved': true,
    'assigned': true
  });
}
}