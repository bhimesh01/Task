import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:task/models/ticketModel.dart';
import 'package:task/screens/details/activityTab.dart';
import 'package:task/screens/details/details.dart';
import '../LoginScreens/login.dart' as login;
import 'package:task/screens/reusableWidgets/customBottomNavBar.dart';

class viewTabBar extends StatefulWidget {
  TicketModel model;
  viewTabBar({Key? key, required this.model}) : super(key: key);

  @override
  _myViewTabBarState createState() => _myViewTabBarState(model);
}

class _myViewTabBarState extends State<viewTabBar> {
  TicketModel model;
  _myViewTabBarState(this.model);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            '${model.ticketID}',
            style: GoogleFonts.poppins(
              color: Color(0xFF2C35BF),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          titleSpacing: 10,
          leading: IconButton(
            padding: EdgeInsets.only(
              left: 20,
              right: 5,
              top: 8,
              bottom: 8,
            ),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: 1,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            TabBar(
              unselectedLabelColor: Color(0xff4750D5).withOpacity(0.62),
              labelColor: Color(0xff4750D5),
              indicatorSize: TabBarIndicatorSize.label,
              indicator: MaterialIndicator(color: Color(0xff4750D5)),
              tabs: [
                Tab(
                    child: Text(
                  "Details",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )),
                Tab(
                  child: Text(
                    "Activity",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
                child: TabBarView(
              children: [
                Center(child: DetailsPage(ticketModel: model)),
                Center(
                    child: ActivityTab(
                        loginModel: login.model, ticketModel: model)),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
