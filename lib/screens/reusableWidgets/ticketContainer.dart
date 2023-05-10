import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/models/ticketModel.dart';
import 'package:task/screens/reusableWidgets/projectStatus.dart';
import 'package:task/screens/reusableWidgets/ticketStatus.dart';
import 'package:task/screens/view/viewTabBar.dart';
import 'package:task/screens/LoginScreens/login.dart';

TicketModel ticketModel = TicketModel(
  ticketID: -1,
  summary: 'summary',
  description: 'description',
  status: '',
  severityState: -1,
  milestone: 'milestone',
  assignedID: -1,
  reportedID: -1,
  taskProjectID: -1,
  totalWorkingHours: 0,
  assignedName: 'assignedName',
  reportedName: 'reportedName',
  tags: 'tags',
);

class TicketContainer extends StatefulWidget {
  int ticketId;
  String summary;
  int assignedID;
  int reportedID;
  String assignedName;
  String reportedName;
  String tags;
  int projectID;
  int progressState;
  int severityState;
  String description;
  String milestone;
  int duration;

  TicketContainer({
    Key? key,
    required this.ticketId,
    required this.description,
    required this.progressState,
    required this.milestone,
    required this.duration,
    required this.summary,
    required this.assignedID,
    required this.reportedID,
    required this.assignedName,
    required this.reportedName,
    required this.tags,
    required this.projectID,
    required this.severityState,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  MyTicketContainerState createState() => MyTicketContainerState(
        ticketId: ticketId,
        description: description,
        progressState: progressState,
        milestone: milestone,
        duration: duration,
        summary: summary,
        assignedID: assignedID,
        reportedID: reportedID,
        assignedName: assignedName,
        reportedName: reportedName,
        tags: tags,
        projectID: projectID,
        severityState: severityState,
      );
}

class MyTicketContainerState extends State<TicketContainer> {
  int ticketId;
  String summary;
  int assignedID;
  int reportedID;
  String assignedName;
  String reportedName;
  String tags;
  int projectID;
  int progressState;
  int severityState;
  String description;
  String milestone;
  int duration;

  MyTicketContainerState({
    Key? key,
    required this.ticketId,
    required this.description,
    required this.progressState,
    required this.milestone,
    required this.duration,
    required this.summary,
    required this.assignedID,
    required this.reportedID,
    required this.assignedName,
    required this.reportedName,
    required this.tags,
    required this.projectID,
    required this.severityState,
  });

  @override
  Widget build(BuildContext context) {
    double devSize = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: InkWell(
          onTap: () {
            setState(() {
              ticketModel.assignedID = assignedID;
              ticketModel.ticketID = ticketId;
              ticketModel.assignedName = assignedName;
              ticketModel.milestone = milestone;
              ticketModel.reportedID = reportedID;
              ticketModel.description = description;
              ticketModel.summary = summary;
              ticketModel.tags = tags;
              ticketModel.status = progressState.toString();
              ticketModel.taskProjectID = projectID;
              ticketModel.totalWorkingHours = duration;
              ticketModel.reportedName = reportedName;
              ticketModel.severityState = severityState;
            });
            print(ticketModel.assignedName);
            Future.delayed(Duration.zero, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => viewTabBar(model: ticketModel)));
            });
          },
          child: Container(
            height: 125,
            width: devSize / 1.1,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
            constraints: BoxConstraints(minHeight: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                attachTicketRow(context, ticketId, progressState),
                textFlex(context, summary),
                attachMileStoneRow(context, milestone, duration),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget attachTicketRow(
      BuildContext context, int ticketId, int progressState) {
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
      child: Row(
        children: [
          Text('#$ticketId',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Color(0xff5369FF),
                fontSize: 14,
              )),
          Spacer(),
          ticketStatus(severityState: severityState),
          SizedBox(
            width: 5,
          ),
          projectStatus(progressState: progressState),
        ],
      ),
    );
  }

  Widget textFlex(BuildContext context, String text) {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 30),
            child: Text(
              text,
              softWrap: false,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color.fromRGBO(10, 11, 18, 0.79),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget attachMileStoneRow(
      BuildContext context, String milestone, int duration) {
    int hours = duration ~/ 60;
    int minutes = duration - hours * 60;
    String hourLeft =
        hours.toString().length < 2 ? "0" + hours.toString() : hours.toString();
    String minuteLeft = minutes.toString().length < 2
        ? "0" + minutes.toString()
        : minutes.toString();
    var converted = "$hourLeft:$minuteLeft";
    return Padding(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
        child: Row(
          children: [
            Image.asset('assets/icons/milestone icon.png'),
            Text(
              milestone,
              style: GoogleFonts.poppins(
                  color: Color(0xff0A0B12),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            Spacer(),
            Image.asset(
              'assets/icons/clock icon.png',
              height: 20,
              width: 20,
            ),
            Text(
              '$converted mins',
              style: GoogleFonts.poppins(
                  color: Color(0xff0A0B12),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ));
  }
}
