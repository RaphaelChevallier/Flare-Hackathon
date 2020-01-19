import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'globals.dart' as globals;
import  'dart:async';
import 'dart:io';
import 'home_widget.dart';


class Reference{
  bool assigned, requester, resolved;
  String category, subcategory, description;
  double latitude, longitude;
  Reference(){
    bool assigned = false;
    bool requester = false;
    bool resolved = false;
    String category = '';
    String subcategory = '';
    String description = '';
    double latitude = 0;
    double longitude = 0;
  }
  void setAssigned(bool assigned){
    this.assigned = assigned;
  }
  void setRequester(bool requester){
    this.requester = requester;
  }
  void setResolved(bool resolved){
    this.resolved = resolved;
  }
  void setCategory(String category){
    this.category = category;
  }
  void setSubcategory(String subcategory){
    this.subcategory = subcategory;
  }
  void setDescription(String description){
    this.description = description;
  }
  void setLatitude(double latitude){
    this.latitude = latitude;
  }
  void setLongitude(double longitude){
    this.longitude = longitude;
  }
}

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

  @override
  void initState() {
    int num = getRequestNumber();
      setState(() {
      this.requestNum = num;
    }); 
    super.initState();
    }

  _RequestWidget(this.color);

//FUNCTION TO READ FROM DATABASE
int getRequestNumber(){
  databaseReference.once().then((DataSnapshot snapshot){
    requestNum = snapshot.value['requestNumber'];
    print(snapshot.value['requestNumber']);
  });
  return requestNum;
}

void updateRequestNum(num){
  DatabaseReference ref = FirebaseDatabase.instance.reference();
  ref.update({
    'requestNumber': num,
  });
}

void createRequest(category, description, latitude, longitude){
  print(latitude);
  updateRequestNum(requestNum+1);
  databaseReference.child("requests").child("request" + "${requestNum+1}").set({
    'category': category,
    'description': description,
    'assigned': false,
    'latitude': latitude,
    'longitude': longitude,
    'requester': 'Beckham',
    'resolved': false
  });
}

//SWITCH STATEMENT FOR SUBCATEGORY
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
      validator: (val){
        if (val.isEmpty) {
            return 'Please enter a description.';
        }
      },
      onSaved: (String val){
        setState(() {description = val;});
      }
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
            categoryName = newValue.toString();
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

  Widget _buildCoverImage(Size screenSize){
    return Container(
      height: screenSize.height/3.6,
      decoration:BoxDecoration(
        image:DecorationImage(
          image: AssetImage ('assets/images/cover.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

 
  
  @override
  Widget build (BuildContext context){
    Size screenSize = MediaQuery.of(context).size;
    TextStyle _rewardTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.red,
      fontSize: 22.0,
      fontWeight: FontWeight.w800,
    );
    TextStyle _labelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    );
    return Scaffold(
      body: Stack(
        children:<Widget>[
          _buildCoverImage(screenSize ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 8.4),

                  Text("Create an alert for users nearby:",
                   style: _rewardTextStyle,),
                  SizedBox(height: screenSize.height / 7.4),

                  //MAIN CATEGORY SELECTION
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Enter your category",
                        style: _labelTextStyle,
                      ),
                     _buildCategory(),
                     ],
                  ),
                  SizedBox(height: screenSize.height / 5.4),

                  //SUBCATEGORY SELECTION
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Enter your subcategory",
                        style: _labelTextStyle
                      ),
                     _buildSubCategory(),
                     ],

                   ),
                   SizedBox(height: screenSize.height / 6.4),

                   //SUBMIT BUTTON
                   _buildDescription(),
                    RaisedButton(
                      child: Text('Submit'),
                      onPressed:() {
                        createRequest(categoryName, subCategoryName.toString(), globals.Lat, globals.Long);
                        final snackBar = SnackBar(
                          content: Text('Request submitted')
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
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