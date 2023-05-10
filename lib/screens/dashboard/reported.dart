import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:task/screens/LoginScreens/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/screens/reusableWidgets/customAppBar.dart';
import 'package:task/screens/reusableWidgets/customBottomNavBar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'package:task/screens/reusableWidgets/ticketContainer.dart';

import 'dashboard.dart';

class ReportedTickets extends StatefulWidget {
  @override
  _myReportedTicketsState createState() => _myReportedTicketsState();
}

List<dynamic> reportedTickets = [];

class _myReportedTicketsState extends State<ReportedTickets> {
  static int curPage = 1;
  bool loadSpinner = true;
  Future<dynamic> getTickets(curPage) async {
    String url =
        "http://194.163.145.243:9007/api/tickets/${prModel.projectID}/reported/${model.userID}/${curPage}";
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
          reportedTickets.addAll(jsonDecode(feedback.body));
        });
      }

      print(reportedTickets.length);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      tabBarStateManager.tabIndex = 1;
      loadSpinner = true;
    });
    if (reportedTickets.isEmpty) {
      getTickets(curPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            curPage = 1;
            reportedTickets = [];
            getTickets(curPage);
          });
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: (reportedTickets.isEmpty)
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
                          itemCount: reportedTickets.length,
                          itemBuilder: ((context, index) {
                            return TicketContainer(
                              ticketId: reportedTickets[index]['ticketId'],
                              description: reportedTickets[index]
                                  ['description'],
                              progressState: reportedTickets[index]['status'],
                              milestone: reportedTickets[index]['milestone'],
                              duration: reportedTickets[index]
                                  ['totalWorkingHours'],
                              assignedID: reportedTickets[index]
                                  ['assignedToId'],
                              assignedName: reportedTickets[index]
                                  ['assignedToName'],
                              reportedID: reportedTickets[index]['reportedId'],
                              reportedName: reportedTickets[index]
                                  ['reportedToName'],
                              tags: (reportedTickets[index]['tags'] == null)
                                  ? 'No Tags'
                                  : reportedTickets[index]['tags'],
                              summary: reportedTickets[index]['summary'],
                              projectID: reportedTickets[index]
                                  ['taskProjectId'],
                              severityState: reportedTickets[index]['severity'],
                            );
                          })),
                      Container(
                        child: TextButton(
                          child: Text('Load More..'),
                          onPressed: () {
                            setState(() {
                              curPage += 1;
                            });
                            Future.delayed(
                                Duration.zero, () => getTickets(curPage));
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
