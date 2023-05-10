import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/screens/reusableWidgets/customAppBar.dart';
import 'package:task/screens/reusableWidgets/customBottomNavBar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'package:task/screens/reusableWidgets/ticketContainer.dart';
import 'package:task/models/userModel.dart';
import 'package:task/screens/LoginScreens/login.dart';
import 'package:task/models/stateManager.dart';
import 'dashboard.dart';

class AssignedTickets extends StatefulWidget {
  bool showAnimation;
  bool fromLogin;
  AssignedTickets({Key? key,required this.showAnimation,required this.fromLogin}) : super(key: key);
  @override
  _myAssignedTicketsState createState() => _myAssignedTicketsState(showAnimation,fromLogin);
}

List<dynamic> assignedTickets = [];

class _myAssignedTicketsState extends State<AssignedTickets> with TickerProviderStateMixin{
  static int curPage = 1;
  bool loadSpinner = true;
  bool showAnimation;
  bool fromLogin;
  AnimationController? animationController;
  Animation<double>? animation;
  _myAssignedTicketsState(this.showAnimation,this.fromLogin);

  Future<dynamic> getTickets() async {
    String url =
        "http://194.163.145.243:9007/api/tickets/${prModel.projectID}/assigned/${model.userID}/${curPage}";

    Future.delayed(Duration.zero, () {
      setState(() {
        url =
            "http://194.163.145.243:9007/api/tickets/${prModel.projectID}/assigned/${model.userID}/${curPage}";
      });
    });
    print(url);
    var feedback = await http.get(Uri.parse(url));
    if (feedback.statusCode == 200) {
      //ok
      if (jsonDecode(feedback.body).isEmpty) {
        setState(() {
          loadSpinner = false;
        });
      } else {
        setState(() {
          assignedTickets.addAll(jsonDecode(feedback.body));
        });
      }
      print(assignedTickets.length);
    } else {
      setState(() {
        assignedTickets = [];
      });
      Fluttertoast.showToast(msg: 'Error fetching data');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      tabBarStateManager.tabIndex = 0;
      loadSpinner = true;
    });
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation =
        CurveTween(curve: Curves.fastOutSlowIn).animate(animationController!);
    if(showAnimation==true && fromLogin==true){
      Future.delayed(Duration.zero,(){
        showOverlay(context,text: 'Welcome to TASK !', status: 1);
      });
    }
    Future.delayed(Duration(seconds: 1), () {
      if (assignedTickets.isEmpty) {
        getTickets();
      }
    });
  }
  void showOverlay(BuildContext context,
      {required String text, required int status}) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: MediaQuery.of(context).size.width * 0.04,
        top: MediaQuery.of(context).size.height * 0.10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            child: FadeTransition(
              opacity: animation!,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 2, color: Color(0xff4750d5)),
                    color: status == 1 ? Color(0xff4750d5) : Colors.white),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    right: MediaQuery.of(context).size.width * 0.02),
                width: MediaQuery.of(context).size.width * 0.93,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                      color: status == 1 ? Colors.white : Color(0xff4750d5),
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
            ),
          ),
        ),
      );
    });
    animationController!.addListener(() {
      overlayState!.setState(() {});
    });
    // inserting overlay entry
    overlayState!.insert(overlayEntry);
    animationController?.forward();
    await Future.delayed(Duration(milliseconds: 650))
        .whenComplete(() => animationController!.reverse())
    // removing overlay entry after stipulated time.
        .whenComplete(() => overlayEntry.remove());
  }
  void dispose(){
    super.dispose();
    animationController!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            curPage = 1;
            assignedTickets = [];
            getTickets();
          });
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: (assignedTickets.isEmpty)
                  ? (loadSpinner == true)
                      ? [
                          Center(
                            child: CircularProgressIndicator(),
                          )
                        ]
                      : [
                          Center(
                            child: Text('No more Tickets!'),
                          ),
                        ]
                  : [
                      ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: assignedTickets.length,
                          itemBuilder: ((context, index) {
                            return TicketContainer(
                              ticketId: assignedTickets[index]['ticketId'],
                              description: assignedTickets[index]
                                  ['description'],
                              progressState: assignedTickets[index]['status'],
                              milestone: assignedTickets[index]['milestone'],
                              duration: assignedTickets[index]
                                  ['totalWorkingHours'],
                              assignedID: assignedTickets[index]
                                  ['assignedToId'],
                              assignedName: assignedTickets[index]
                                  ['assignedToName'],
                              reportedID: assignedTickets[index]['reportedId'],
                              reportedName: assignedTickets[index]
                                  ['reportedToName'],
                              tags: (assignedTickets[index]['tags'] == null)
                                  ? 'No Tags'
                                  : assignedTickets[index]['tags'],
                              summary: assignedTickets[index]['summary'],
                              projectID: assignedTickets[index]
                                  ['taskProjectId'],
                              severityState: assignedTickets[index]['severity'],
                            );
                          })),
                      Container(
                        child: TextButton(
                          child: Text('Load More..'),
                          onPressed: () {
                            print(url);
                            setState(() {
                              curPage += 1;
                            });
                            Future.delayed(Duration.zero, () => getTickets());
                          },
                        ),
                      )
                    ],
            ),
          ),
        ),
      ),
    );
  }
}
