import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/screens/reusableWidgets/activityTicketContainer.dart';
import 'package:task/screens/reusableWidgets/addnote.dart';
import 'package:task/screens/LoginScreens/login.dart';
import 'package:task/models/userModel.dart';
import 'package:task/models/noteModel.dart';
import 'package:http/http.dart' as http;

import '../../models/ticketModel.dart';

class ActivityTab extends StatefulWidget {
  TicketModel ticketModel;
  UserModel loginModel;

  ActivityTab({
    Key? key,
    required this.ticketModel,
    required this.loginModel,
  }) : super(key: key);
  @override
  _myActivityTabState createState() =>
      _myActivityTabState(this.ticketModel, this.loginModel);
}

class _myActivityTabState extends State<ActivityTab>
    with TickerProviderStateMixin {
  TicketModel ticketModel;
  UserModel loginModel;
  AnimationController? animationController;
  Animation<double>? animation;
  _myActivityTabState(this.ticketModel, this.loginModel);
  //http://194.163.145.243:9007/api/notes/{ticketid}/note/{userid}

  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation =
        CurveTween(curve: Curves.fastOutSlowIn).animate(animationController!);
    Future.delayed(Duration(seconds: 1), () {
      if (notes.isEmpty) {
        getTickets();
      }
    });
  }
  bool loadSpinner = true;
  var length_is = 0;
  List<dynamic> notes = [];
  Future<dynamic> getTickets() async {
    String url =
        "http://194.163.145.243:9007/api/notes/${ticketModel.ticketID}/note/${loginModel.userID}";

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
          notes.addAll(jsonDecode(feedback.body));
        });
      }
      print(notes.length);
    } else {
      setState(() {
        notes = [];
      });
      Fluttertoast.showToast(msg: 'Error fetching data');
    }
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

  Widget build(BuildContext context) {
    print(ticketModel.ticketID);
    print(loginModel.userID);
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body:RefreshIndicator(
        onRefresh: () async {
      setState(() {
        notes = [];
        getTickets();
      });
    },
    child: SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
          (notes.isEmpty)
            ? (loadSpinner == true)
          ? [
              Center(
                child: CircularProgressIndicator(),
               )
            ]: [
              Center(
                child: Text('No more Tickets!'),
                ),
                ]:
          [
            ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: notes.length,
                itemBuilder: ((context, index) {
                      return activityTicketContainer(
                              noteId: notes[index]['noteId'],
                             detailText: ((notes[index]['note']).length == 0) ? 'Empty Note'
                                           : notes[index]['note'].trim(),
                              userName: notes[index]['userName'],
                              duration: notes[index]['timeSpent'].toString(),
                              ticketId: ticketModel.ticketID.toString(),
                            );
                })
              ),
          ]
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddPage(
                      model: ticketModel,
                      workedHours: "00:00",
                    )),
          );

          if (result != null && result == false) {
            //discard
            showOverlay(context,
                text: 'Your Activity has not been saved.', status: 0);
          }
          if (result != null && result == true) {
            //save changes :)
            showOverlay(context,
                text: 'Your Activity has been saved successfully !', status: 1);
          }
        },
        backgroundColor: const Color(0xff4750D5),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
