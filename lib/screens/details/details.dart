import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/screens/view/view.dart';

import '../../models/ticketModel.dart';
import '../reusableWidgets/projectStatus.dart';
import '../reusableWidgets/ticketStatus.dart';

class DetailsPage extends StatefulWidget {
  TicketModel ticketModel;
  DetailsPage({
    Key? key,
    required this.ticketModel,
  }) : super(key: key);

  @override
  DetailsState createState() => DetailsState(this.ticketModel);
}

class DetailsState extends State<DetailsPage> {
  TicketModel model;
  DetailsState(this.model);
  String convertTime(int totalTime) {
    int hours = totalTime ~/ 60;
    int minutes = totalTime - hours * 60;

    String hourLeft =
        hours.toString().length < 2 ? "0" + hours.toString() : hours.toString();
    String minuteLeft = minutes.toString().length < 2
        ? "0" + minutes.toString()
        : minutes.toString();
    String newTime = "$hourLeft:$minuteLeft";
    return newTime;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 28, right: 28),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            '${model.summary}',
                            maxLines: 5,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        ticketStatus(severityState: (model.severityState)),
                        SizedBox(
                          width: 20,
                        ),
                        projectStatus(progressState: int.parse(model.status)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/milsetone highlighted.png',
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${model.milestone}",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF222995),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/clock icon.png',
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          convertTime(model.totalWorkingHours),
                          style: GoogleFonts.poppins(
                            color: Color(0xFF222995),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    Row(
                      children: [
                        Text(
                          "Description",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF222995),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${model.description}",
                            maxLines: 10,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Image.asset('assets/icons/tags icon.png'),
                        SizedBox(
                          width: 9,
                        ),
                        Text(
                          "Tags",
                          style: GoogleFonts.poppins(
                            color: Color(0xff222995),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 48,
                        ),
                        Expanded(
                            child: Text(
                          model.tags == null ? 'No tags' : '${model.tags}',
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    Row(
                      children: [
                        Text(
                          "Reported by",
                          style: GoogleFonts.poppins(
                              color: Color(0xff222995),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          radius: 14,
                          child: Text(model.reportedName[0]),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${model.reportedName}",
                          style: GoogleFonts.poppins(
                              color: Color(0xff0A0B12),
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Assigned to",
                          style: GoogleFonts.poppins(
                            color: Color(0xff222995),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        CircleAvatar(
                          radius: 14,
                          child: Text(model.reportedName[0]),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${model.assignedName}",
                          style: GoogleFonts.poppins(
                              color: Color(0xff0A0B12),
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
