import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/models/stateManager.dart';
import 'package:task/screens/dashboard/assigned.dart';
import 'package:task/screens/dashboard/followed.dart';
import 'package:task/screens/dashboard/reported.dart';
import 'package:task/screens/reusableWidgets/customAppBar.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:task/screens/reusableWidgets/customBottomNavBar.dart';

// import 'menu.dart';
TabBarStateManager tabBarStateManager = TabBarStateManager(tabIndex: 0);

@override
class Dashboard extends StatefulWidget {
  bool showAnimation;
  bool fromLogin;
  Dashboard({Key? key,required this.showAnimation,required this.fromLogin}) : super(key: key);
  MyDashboardState createState() => MyDashboardState(showAnimation,fromLogin);
}

class MyDashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool showAnimation;
  bool fromLogin;
  MyDashboardState(this.showAnimation,this.fromLogin);

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.animateTo(tabBarStateManager.tabIndex);
    print(showAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFE5E5E5),
      child: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              unselectedLabelColor: Color(0xff4750D5).withOpacity(0.62),
              labelColor: Color(0xff4750D5),
              indicatorSize: TabBarIndicatorSize.label,
              indicator: MaterialIndicator(color: Color(0xff4750D5)),
              tabs: [
                Tab(
                  child: Text(
                    "Assigned",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Tab(
                  child: Text(
                    "Reported",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Tab(
                  child: Text(
                    "Followed",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Center(
                    child: AssignedTickets(showAnimation: showAnimation,fromLogin: fromLogin,),
                  ),
                  Center(
                    child: ReportedTickets(),
                  ),
                  Center(
                    child: FollowedTickets(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
