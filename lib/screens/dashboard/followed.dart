import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/screens/reusableWidgets/customAppBar.dart';
import 'package:task/screens/reusableWidgets/customBottomNavBar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:task/screens/reusableWidgets/ticketContainer.dart';
import 'package:task/models/userModel.dart';
import 'package:task/screens/LoginScreens/login.dart';

import 'dashboard.dart';

class FollowedTickets extends StatefulWidget {
  @override
  _myFollowedTickets createState() => _myFollowedTickets();
}

class _myFollowedTickets extends State<FollowedTickets> {
  @override
  static int curPage = 1;
  List<dynamic> tickets = [];
  bool loadSpinner = true;
  Future<dynamic> getTickets() async {
    String url =
        "http://194.163.145.243:9007/api/tickets/${prModel.projectID}/followed/${model.userID}/${curPage}";
    var feedback = await http.get(Uri.parse(url));
    if (feedback.statusCode == 200) {
      //ok
      if (jsonDecode(feedback.body).isEmpty) {
        setState(() {
          loadSpinner = false;
        });
      } else {
        setState(() {
          tickets.addAll(jsonDecode(feedback.body));
        });
      }

      print(tickets.length);
    } else {
      setState(() {
        tickets = [];
      });
      Fluttertoast.showToast(msg: 'Error fetching data');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      tabBarStateManager.tabIndex = 2;
      loadSpinner = true;
    });
    getTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            curPage = 1;
            tickets = [];
            getTickets();
          });
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: (tickets.isEmpty)
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
                          itemCount: tickets.length,
                          itemBuilder: ((context, index) {
                            print(tickets[index]['description']);
                            return TicketContainer(
                              ticketId: tickets[index]['ticketId'],
                              description: tickets[index]['description'],
                              progressState: tickets[index]['status'],
                              milestone: tickets[index]['milestone'],
                              duration: tickets[index]['totalWorkingHours'],
                              assignedID: tickets[index]['assignedToId'],
                              assignedName: tickets[index]['assignedToName'],
                              reportedID: tickets[index]['reportedId'],
                              reportedName: tickets[index]['reportedToName'],
                              tags: (tickets[index]['tags'] == null)
                                  ? 'No Tags'
                                  : tickets[index]['tags'],
                              summary: tickets[index]['summary'],
                              projectID: tickets[index]['taskProjectId'],
                              severityState: tickets[index]['severity'],
                            );
                          })),
                      Container(
                        child: TextButton(
                          child: Text('Load More..'),
                          onPressed: () {
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
