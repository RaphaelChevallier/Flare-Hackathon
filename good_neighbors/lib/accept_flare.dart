import 'package:flutter/material.dart';
import 'success.dart';

class AcceptFlare extends StatelessWidget {
  final object;
  String keys;

  AcceptFlare(this.object, this.keys);

  @override
  Widget build(BuildContext context) {
    print(object);
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: <Widget>[
         Text(
          object['requester'] + " is calling for your help!",
          style: _statLabelTextStyle,
        ),
        SizedBox(height: 20),
        Text(
          "They want help with " + object['category'],
          style: _statLabelTextStyle,
        ),
        SizedBox(height: 20),
       Text(
          "SUMMARY: " + object['description'],
          style: _statLabelTextStyle,
        ),
        SizedBox(height: 20),
        Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              RaisedButton(child: Text("Go back to map"),
                onPressed: () {Navigator.pop(context);},
                color: Colors.red,
                textColor: Colors.black,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                splashColor: Colors.redAccent,
              ),
              SizedBox(width: 35),
               RaisedButton(child: Text("Volunteer your help"),
                onPressed: () { Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Success(object, keys),
                  ),
                  );},
                color: Colors.blue,
                textColor: Colors.black,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                splashColor: Colors.blueAccent,
              ),
        ])
      ],)
    );
  }
}