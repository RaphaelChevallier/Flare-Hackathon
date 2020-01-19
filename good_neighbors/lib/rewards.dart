import 'package:flutter/material.dart';

class Rewards extends StatelessWidget {
  final String rewardImgURL='assets/images/smileyPicture.jpg';
  final String rewardName='Smile';
  final int rewardPoints=10;

  //rRewards(this.rewardName, this.rewardImgURL);

  Widget _buildRewardImage(){
    return Center(
      child: Container(
        width:140.0,
        height:140.0,
        decoration:BoxDecoration(
          image:DecorationImage(
            image: AssetImage (rewardImgURL),
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
   Widget _buildRewardName(){
     TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      rewardName!=null?rewardName:'default',
      style: _nameTextStyle,
    );
   }


   Widget _buildRewardPoints(){
     TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      rewardPoints.toString()+" points worth",
      style: _nameTextStyle,
    );
   }

   @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children:<Widget>[
          SafeArea(
            child: SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  _buildRewardName(),
                  _buildRewardImage(),
                  _buildRewardPoints()

                ],
              ),
            ),
          ),
          
        ],

      ),
    );
  }












}

