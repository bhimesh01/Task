import 'package:flutter/material.dart';
import 'package:task/screens/dashboard/dashboard.dart';
import 'package:task/screens/milestone/milestone.dart';
import 'package:task/screens/reusableWidgets/comingSoonScreen.dart';
import 'package:task/screens/reusableWidgets/customAppBar.dart';
import 'package:task/screens/reusableWidgets/customBottomNavBar.dart';
import 'package:task/screens/view/view.dart';

class MainBody extends StatefulWidget {
  int index = 0;

  MainBody({Key? key, required this.index}) : super(key: key);
  MainBodyState createState() => MainBodyState(this.index);
}

class MainBodyState extends State<MainBody> {
  int index = 0;
  int prevIndex = 0; //fix for search :)
  List<Widget> ListScreens = [
    Dashboard(showAnimation: false,fromLogin: false,),
    View(),
    Milestone(),
    comingSoonScreen(),
  ];

  MainBodyState(this.index);

  void _onTap(int itemIndex) {
    setState(() {
      index = itemIndex;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      body: ListScreens[index],
      appBar: MyAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            // icon: Icon(
            //   Icons.home_filled,
            // ),
            icon: Image.asset(
              'assets/icons/home.png',
              height: 30,
              width: 20,
            ),
            activeIcon: Image.asset(
              'assets/icons/home highlighted.png',
              height: 30,
              width: 20,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/view ticket.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'assets/icons/view ticket highlighted.png',
              height: 20,
              width: 20,
            ),
            label: 'View',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(2.0),
              child: Image.asset(
                'assets/icons/milestonebottom.png',
                height: 20,
                width: 20,
              ),
            ),
            activeIcon: Container(
              child: Image.asset(
                'assets/icons/bottomMilestoneHigh.png',
                height: 20,
                width: 20,
              ),
              padding: EdgeInsets.all(
                2.0,
              ),
            ),
            label: 'Milestone',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/search icon.png',
              height: 20,
              width: 20,
            ),
            label: 'Search',
          ),
        ],
        selectedItemColor: Color(0xff4750D5),
      ),
    );
  }
}
