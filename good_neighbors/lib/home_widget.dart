import 'package:flutter/material.dart';
import 'placeholder_widget.dart';
import 'google_maps_view.dart';
<<<<<<< HEAD
import 'requests.dart';
=======
import 'profile.dart';
>>>>>>> 1a8c1a2f631e5d1790e5ac2f4d800a634ca8d075

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
    RequestWidget(),
    PlaceholderWidget(Colors.green),
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
<<<<<<< HEAD
             icon: Icon(Icons.person),
             title: Text('Profile')
           )
=======
           icon: Icon(Icons.person),
            title: Text('Profile')
          )
>>>>>>> 1a8c1a2f631e5d1790e5ac2f4d800a634ca8d075
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