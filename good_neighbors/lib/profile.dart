import 'package:flutter/material.dart';
import 'star_display.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class UserProfile extends StatefulWidget{
@override
  State<StatefulWidget> createState() {
    return _UserProfile();
  }
}

class _UserProfile extends State<UserProfile> {
  
  // final String _firstName="Aaron";
  // final String _lastName="Burr";
  String name= " ";
  int rating = 0;
  int helpedPeople = 0;
  String _bio="Wait for it";
  // final int _score=3;
  // final int _helped=5;
  
   @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child("profile").child("1").once().then((DataSnapshot snap){
      name = snap.value['name'].toString();
      rating = int.parse(snap.value['rating'].toString());
      helpedPeople = int.parse(snap.value['peopleHelped'].toString());
      setState(() {
      this.rating = rating;
      this.name = name;
      this.helpedPeople = helpedPeople;
    }); 
    });
    super.initState();
  }
  

  Widget _buildStarDisplay(){
    return StarDisplay(value: rating);
  }

  Widget _buildCoverImage(Size screenSize){
    return Container(
      height: screenSize.height/2.6,
      decoration:BoxDecoration(
        image:DecorationImage(
          image: AssetImage ('assets/images/cover.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage(){
    return Center(
      child: Container(
        width:140.0,
        height:140.0,
        decoration:BoxDecoration(
          image:DecorationImage(
            image: AssetImage ('assets/images/photo.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),

        ), 
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      name,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatItem(String label, int count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

     return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  } 

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Helped", helpedPeople),
          _buildStatItem("Score", rating),
        ],
      ),
    );
  }


   Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400,//try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

    Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children:<Widget>[
          _buildCoverImage(screenSize ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4),
                  _buildProfileImage(),
                  _buildFullName(),
                  _buildStatContainer(),
                  _buildBio(context),
                  _buildSeparator(screenSize),
                  _buildStarDisplay(),
                ],
              ),
            ),
          ),
          
        ],

      ),
    );
  }
}


class Person {
  String name;
  double rating;
  int peopleHelped;

  Person(this.name, this.rating, this.peopleHelped);
}