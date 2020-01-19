import 'package:flutter/material.dart';
import 'star_display.dart';

class UserProfile extends StatelessWidget {
  final String _firstName="Aaron";
  final String _lastName="Burr";
  final String _bio="Wait for it";
  final int _score=3;
  final int _helped=5;

  Widget _buildStarDisplay(){
    return StarDisplay(value: _score);
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
      _firstName,
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
          _buildStatItem("Helped", _helped),
          _buildStatItem("Score", _score),
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

