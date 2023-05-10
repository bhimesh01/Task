import 'package:flutter/material.dart';
import 'package:task/screens/dashboard/dashboard.dart';
import 'package:task/screens/milestone/milestone.dart';
import 'package:task/screens/reusableWidgets/comingSoonScreen.dart';
import 'package:task/screens/view/view.dart';
import 'customAppBar.dart';
import 'package:task/models/stateManager.dart';

BottomStateManager manager = BottomStateManager(bottomNavBarIndex: 0);

class CustomBottomNavigationBar extends StatefulWidget {
  int selectedIndex;
  CustomBottomNavigationBar({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  _myBottomNavBarState createState() =>
      _myBottomNavBarState(this.selectedIndex);
}

class _myBottomNavBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex;
  int prevIndex = 0; //fix for search :)
  _myBottomNavBarState(this._selectedIndex);

  void _onTap(int itemIndex) {
    setState(() {
      if (_selectedIndex != 3) {
        //if index is not search index update prev index
        prevIndex = _selectedIndex;
      }
      _selectedIndex = itemIndex;
    });

    switch (_selectedIndex) {
      case 0:
        setState(() {
          manager.bottomNavBarIndex = 0;
        });
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Dashboard(showAnimation: false,fromLogin: false,),
        ));
        break;
      case 1:
        setState(() {
          manager.bottomNavBarIndex = 1;
        });
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => View(),
        ));
        break;
      case 2:
        setState(() {
          manager.bottomNavBarIndex = 2;
        });
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Milestone(),
        ));
        break;
      case 3:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => comingSoonScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: (_selectedIndex == 3) ? prevIndex : _selectedIndex,
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
    );
  }
}
