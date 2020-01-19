import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'globals.dart' as globals;

class RequestWidget extends StatefulWidget {
  RequestWidget({Key key}) : super(key: key);

  @override
  _RequestWidget createState() => new _RequestWidget(Colors.deepOrange);
}

class _RequestWidget extends State<RequestWidget> {
  Color color;
  String categoryName;
  String subCategoryName;
  String description;
  List<String> subCatList  = <String>[];
  final databaseReference = FirebaseDatabase.instance.reference();
  int requestNum;

  _RequestWidget(this.color);

int getRequestNumber(){
  databaseReference.child("requestNumber").once().then((DataSnapshot snapshot){
    requestNum = snapshot.value();
  });
  return requestNum;
}

void createRequest(){
  int num = getRequestNumber();
  String temp = "request" + num.toString();
  databaseReference.child("requests").child(temp).set({
    'assigned': false,
    'category': categoryName,
    'description': description,
    'latitude': globals.Lat,
    'longitude': globals.Long,
    'requester': false,
    'resolved': false,
    'subcategory': subCategoryName
  });
  databaseReference.set({
    'requestNumber': ++num
  });
}

  _switchStatement(){
              if(categoryName == "Health") {
                subCatList=["Ride to the emergency room", "Medication delivered", "Injured", "Other"];
              } else if (categoryName== "Automotive"){
                subCatList = ["Need a jump start", "Need a tow", "Need a pump", "Ran out of gas", "Other"];
              } else if (categoryName == "At-Home"){
                subCatList = ["Need driveway shoveled", "Need help bringing groceries in", "My pet is lost", "Other"];
              } else if (categoryName == "Weather"){
                subCatList = ["Need heating supplies for extreme weather", "Other"];
              } 

  }
  Widget _buildDescription(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Description'),
      validator: (value){
        if (value.isEmpty) {
            return 'Please enter a description.';
        }
      },
      onSaved: (val) => setState(() => description = val),
    );
  }
  Widget _buildSubCategory(){
    _switchStatement();
    if(subCatList!=null){
      return DropdownButton<String>(
        value: subCategoryName,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
          color: Colors.red
        ),
        underline: Container(
          height: 2,
          color: Colors.red,
        ),
        onChanged: (String newValue) {
          setState(() {
            subCategoryName = newValue;
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
      );
    }
  }
  Widget _buildCategory(){
    return DropdownButton<String>(
        value: categoryName,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
          color: Colors.red
        ),
        underline: Container(
          height: 2,
          color: Colors.red,
        ),
        onChanged: (String newValue) {
          setState(() {
            categoryName = newValue;
            subCategoryName=null;
          });

        },
        items: <String>['Health','Automotive','At-Home','Weather']
          .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          })
          .toList(),
  );        
  }

  @override
  Widget build (BuildContext context){
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children:<Widget>[
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Enter your category",
                        textAlign: TextAlign.center,
                      ),
                     _buildCategory(),
                     ],
                  ),

                  //SUBCATEGORY 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Enter your subcategory",
                        textAlign: TextAlign.center,
                      ),
                     _buildSubCategory(),
                     ],

                   ),

                   //SUBMIT BUTTON
                   _buildDescription(),
                    RaisedButton(
                      child: Text('Submit'),
                      onPressed:(){
                        createRequest();
                      },
                    ),
                ],

              ),
            ),
          ),
          
        ],

      ),
    );
  }
}