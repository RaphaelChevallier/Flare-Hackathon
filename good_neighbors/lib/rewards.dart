import 'package:flutter/material.dart';

class Rewards extends StatelessWidget {
  

  //rRewards(this.rewardName, this.rewardImgURL);

  Widget _buildRewardImage(String rewardImgURL){
    return Center(
      child: Container(
        width:70.0,
        height:70.0,
        decoration:BoxDecoration(
          image:DecorationImage(
            image: AssetImage (rewardImgURL),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 5.0,
          ),

        ), 
      ),
    );
   }
   Widget _buildRewardName(String rewardName){
     TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    return Text(
      rewardName!=null?rewardName:'default',
      style: _nameTextStyle,
    );
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

   Widget _buildRewardPoints(int rewardPoints){
     TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    return Text(
      rewardPoints.toString()+" points worth",
      style: _nameTextStyle,
    );
   }

  

  Widget _buildStatContainer(String rewardName,String rewardImgURL,int rewardPoints) {
    return Container(
      height: 120.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildRewardName(rewardName),
          _buildRewardImage(rewardImgURL),
          _buildRewardPoints(rewardPoints),
           RaisedButton(child: Text("Redeem"),
                onPressed: () {},
                color: Colors.red,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                splashColor: Colors.redAccent,
              ),
        ],
      ),
    );
  }
   @override
  Widget build(BuildContext context) {
    TextStyle _rewardTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.red,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children:<Widget>[
          _buildCoverImage(screenSize ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 8.4),
                  Text("Rewards available",
                   style: _rewardTextStyle,),
                  _buildStatContainer("Smile","assets/images/smileyPicture.jpg",10),
                  _buildStatContainer("High five","assets/images/highFive.jpg",4)
                ],
              ),
            ),
          ),
          
        ],

      ),
    );
  }












}

