import 'package:flutter/material.dart';
import 'placeholder_widget.dart';
import 'google_maps_view.dart';
import 'requests.dart';
import 'profile.dart';
import 'rewards.dart';


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    GetCurrentLocation(),
    Rewards(),
    RequestWidget(),
    UserProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Map'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            title: Text('Request Help'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.redeem),
            title: Text('Rewards'),
          ),
          BottomNavigationBarItem(
             icon: Icon(Icons.person),
             title: Text('Profile')
           )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    }); 
  }
}