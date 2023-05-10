//All tickets:
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/screens/reusableWidgets/customAppBar.dart';
import 'package:task/screens/reusableWidgets/customBottomNavBar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:task/screens/reusableWidgets/ticketContainer.dart';

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  ViewState createState() => ViewState();
}

class ViewState extends State<View> {
  static int curPage = 1;
  List<dynamic> tickets = [];

  Future<dynamic> getTickets(curPage) async {
    String url =
        "http://194.163.145.243:9007/api/tickets/${prModel.projectID}/${curPage}";
    var feedback = await http.get(Uri.parse(url));
    if (feedback.statusCode == 200) {
      //ok
      if (jsonDecode(feedback.body).isEmpty) {
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
    curPage = 1;
    getTickets(curPage);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          curPage = 1;
          tickets = [];
          getTickets(curPage);
        });
      },
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: (tickets.isEmpty)
                ? [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ]
                : [
                    ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tickets.length,
                        itemBuilder: ((context, index) {
                          return TicketContainer(
                            ticketId: tickets[index]['ticketId'],
                            description: tickets[index]['summary'],
                            progressState: (tickets[index]['status']),
                            milestone: tickets[index]['milestone'],
                            duration: tickets[index]['totalWorkingHours'],
                            assignedID: tickets[index]['assignedToId'],
                            assignedName: tickets[index]['assignedToName'],
                            reportedID: tickets[index]['reportedId'],
                            reportedName: tickets[index]['reportedToName'],
                            tags: tickets[index]['tags'].toString(),
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
                          Future.delayed(
                              Duration.zero, () => getTickets(curPage));
                        },
                      ),
                    )
                  ],
          ),
        ),
      ),
    );
  }
}
