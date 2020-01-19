import 'package:flutter/material.dart';
class RequestWidget extends StatefulWidget {
  RequestWidget({Key key}) : super(key: key);

  @override
  _RequestWidget createState() => new _RequestWidget(Colors.deepOrange);
}

class _RequestWidget extends State<RequestWidget> {
  Color color;
  String mainCategory = 'Type of Issue';
  //String subCategory = 'Specific Type';
  //int index = 0;
  //List<String> subCatList  = <String>[];
  //bool other = false;

  _RequestWidget(this.color);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[

            //HEADER FOR MAIN CATEGORY
            Text('Type of Issue?',
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

        //CREATING MAIN CATEGORY DROPDOWN
        DropdownButton<String>(
          value: mainCategory,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
            size: 16,
          ),
          onChanged: (String newValue) {
            setState(() {
              mainCategory = newValue;
              //SETTING SUBCATEGORY IDENTIFIERS
              /* if(mainCategory == "Health") {
                subCatList = ["I need a ride to the emergency room", "I need medication delivered", "I'm injured", "Other"];
              } else if (mainCategory == "Automotive"){
                subCatList = ["I need a jump start", "I need a tow", "I need a pump", "I ran out of gas", "Other"];
              } else if (mainCategory == "At-Home"){
                subCatList = ["I need someone to shovel my driveway", "I need help bringing groceries in", "My pet is lost", "Other"];
              } else if (mainCategory == "Weather"){
                subCatList = ["I need heating supplies for extreme weather", "Other"];
              } else if (mainCategory == "Other"){
                //HIDE THE SUBCATEGORY
                //TO DO
              } */
            });
          },
          items: <String>['Health', 'Automotive', 'At-Home', 'Weather', 'Other']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
        ),

        //CREATING SUBCATEGORY DROPDOWN
        /*DropdownButton<String>(
          value: subCategory,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
            size: 16,
          ),
          onChanged: (String newValue) {
            setState(() {
              subCategory = newValue;
            });
          },
          items: subCatList
          .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            })
            .toList(),
        ), */

        //TEXT BOX FOR USER TO INPUT REQUEST DESCRIPTION
        TextField(
          obscureText: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Enter here a description of your problem.',
          ),
        )
            ],
          )
      )
    );
  }
}