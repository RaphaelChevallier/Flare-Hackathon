import 'package:flutter/material.dart';

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
   

     
  //bool other = false;

  _RequestWidget(this.color);




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
      validator: (value) {
        if (value.isEmpty) {
            return 'Please enter description.';
        }
      },
      onSaved: (val) => setState(() => description = val),
    );
  }
  Widget _buildSubCategory(String categoryName){
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Enter your subcategory",
                        textAlign: TextAlign.center,
                      ),
                     _buildSubCategory(categoryName),
                     ],

                   ),
                   _buildDescription(),
                    RaisedButton(
                      child: Text('Submit'),
                      onPressed:(){

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
  // Widget build(BuildContext context){
  //   return Scaffold(
  //       drawer: Drawer(
  //         child: ListView(
  //           padding: EdgeInsets.zero,
  //           children: <Widget>[

  //           //HEADER FOR MAIN CATEGORY
  //           Text('Type of Issue?',
  //             textAlign: TextAlign.left,
  //             overflow: TextOverflow.ellipsis,
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),

  //       //CREATING MAIN CATEGORY DROPDOWN
        

  //       //CREATING SUBCATEGORY DROPDOWN
  //       /*DropdownButton<String>(
  //         value: subCategory,
  //         icon: Icon(
  //           Icons.arrow_drop_down,
  //           color: Colors.black,
  //           size: 16,
  //         ),
  //         onChanged: (String newValue) {
  //           setState(() {
  //             subCategory = newValue;
  //           });
  //         },
  //         items: subCatList
  //         .map<DropdownMenuItem<String>>((String value) {
  //             return DropdownMenuItem<String>(
  //               value: value,
  //               child: Text(value),
  //             );
  //           })
  //           .toList(),
  //       ), */

  //       //TEXT BOX FOR USER TO INPUT REQUEST DESCRIPTION
  //       TextField(
  //         obscureText: false,
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(),
  //           labelText: 'Enter here a description of your problem.',
  //         ),
  //       )
  //           ],
  //         )
  //     )
  //   );
  // }
}