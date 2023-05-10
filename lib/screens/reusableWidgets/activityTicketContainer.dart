import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/screens/reusableWidgets/addnote.dart';
import 'package:task/screens/LoginScreens/login.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:task/models/userModel.dart';
import 'package:task/screens/reusableWidgets/ticketContainer.dart';

class activityTicketContainer extends StatefulWidget {
  int? attachState;
  String detailText;
  String userName;
  String duration;
  String ticketId;
  int noteId;
  activityTicketContainer(
      {Key? key,
      required this.detailText,
      this.attachState = 0,
      required this.userName,
      required this.duration,
        required this.noteId,
      required this.ticketId})
      : super(key: key);
  _MyActivityTicketContainerState createState() =>
      _MyActivityTicketContainerState(
          detailText: detailText,
          userName: userName,
          duration: duration,
          noteId : noteId,
          ticketId: ticketId);
}

class _MyActivityTicketContainerState extends State<activityTicketContainer>
    with TickerProviderStateMixin {
  int? attachState;
  String detailText;
  String userName;
  String duration;
  String ticketId;
  int noteId;
  AnimationController? animationController;
  Animation<double>? animation;
  _MyActivityTicketContainerState(
      {required this.detailText,
      this.attachState = 0,
      required this.userName,
        required this.noteId,
      required this.duration,
      required this.ticketId});


  void initState() {

    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation =
        CurveTween(curve: Curves.fastOutSlowIn).animate(animationController!);
  }

  void dispose(){
    animationController!.dispose();
    super.dispose();
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
    animationController!.forward();
    await Future.delayed(Duration(milliseconds: 650))
        .whenComplete(() => animationController!.reverse())
        // removing overlay entry after stipulated time.
        .whenComplete(() => overlayEntry.remove());
  }

  String changeTime(int totalMinutes){
    int hours = totalMinutes~/60;
    int minutes = totalMinutes - hours*60;
    String hourLeft = hours.toString().length < 2 ? "0" + hours.toString() : hours.toString();
    String minuteLeft = minutes.toString().length < 2 ? "0" + minutes.toString() : minutes.toString();
    var finalTime = "$hourLeft:$minuteLeft";
    return finalTime;
  }


  @override
  Widget build(BuildContext context) {
    duration = changeTime(int.parse(duration));
    double devSize = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8.0)
          ),
          height: 140,
          width: devSize / 1.2,
          child: InkWell(
            onTap: () async {
              print(noteId);
              var test = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPage(
                    model: ticketModel,
                    description: detailText,
                    workedHours: duration,
                    isEdit:true,
                      noteId: noteId,
                  ),
                ),
              );
              if (test != null && test == false) {
                showOverlay(context,
                    text: 'Your Activity has not been saved.', status: 0);
              }
              if (test != null && test == true) {
                showOverlay(context,
                    text: 'Your Activity has been saved successfully !',
                    status: 1);
              }
            },
            child: Ink(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  attachTextRow(context, detailText, attachState!),
                  attachUserRow(context, userName, duration),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget attachUserRow(BuildContext context, String username, String duration) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ProfilePicture(
              name: '${model.username}',
              radius: 15,
              fontsize: 15,
            ),
          ),
        ),
        Text(username,style:GoogleFonts.poppins(fontWeight: FontWeight.w400,
          fontSize: 12),),
        Spacer(),
        Icon(Icons.timer_outlined),
        Padding(
          child: Text('$duration mins',style:GoogleFonts.poppins(fontWeight: FontWeight.w400,
              fontSize: 12) ,),
          padding: EdgeInsets.only(right: 10),
        ),
      ],
    );
  }

  Widget attachTextRow(
      BuildContext context, String widgetText, int attachState) {
    var trimmedText = widgetText;
    trimmedText.splitMapJoin("\n");
    if (attachState == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Text(
                trimmedText,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 12)
      ),
            ),
          ),
          Padding(
            child: Image.asset(
              'assets/icons/attachmentIcon.png',
              width: 20,
              height: 20,
            ),
            padding: EdgeInsets.only(bottom: 10, right: 20),
          ),
        ],
      );
    } else {
      print(noteId);
      return Row(
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10, right: 30),
              child: Text(trimmedText,overflow: TextOverflow.ellipsis,maxLines: 2,),
            ),
          ),
        ],
      );
    }
  }
}