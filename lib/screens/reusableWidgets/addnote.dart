import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:task/screens/details/details.dart';
import 'package:task/screens/reusableWidgets/customBottomNavBar.dart';
import 'package:task/screens/view/view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:task/screens/LoginScreens/login.dart';
import '../../models/addNoteModel.dart';
import '../../models/ticketModel.dart';

class AddPage extends StatefulWidget {
  String? description;
  String? workedHours;
  TicketModel model;
  bool? isEdit;
  int? noteId;
  AddPage(
      {Key? key,
      this.description,
      this.workedHours,
      required this.model,
      this.isEdit,
      this.noteId})
      : super(key: key);

  @override
  AddPageState createState() => AddPageState(
      this.description, this.workedHours, this.model, this.isEdit, this.noteId);
}

class AddPageState extends State<AddPage> {
  TicketModel model;

  //AddPageState(this.description,this.workedHours,this.model);
  final myController = TextEditingController();

  // AnimationController? animationController;
  // Animation<double>? animation;

  String? _selectedTime;
  String? description;
  bool functionCalled = false;
  bool? isEdit;
  int? noteId;
  AddPageState(this.description, this._selectedTime, this.model, this.isEdit,
      this.noteId);

  @override
  void initState() {
    super.initState();
    if (description == null) {
      myController.text = '';
    } else {
      myController.text = description!;
    }
  }

  @override
  void dispose() {
    _selectedTime = "00:00";
    myController.dispose();
    super.dispose();
  }

  //Time Picker
  Future<void> _show() async {
    functionCalled = true;
    final TimeOfDay? result = await showTimePicker(
        confirmText: 'Done',
        cancelText: 'Cancel',
        useRootNavigator: false,
        context: context,
        initialTime: const TimeOfDay(hour: 00, minute: 00),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 12-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 24-Hour format, just change alwaysUse24HourFormat to true
              child: child!);
        });
    if (result != null) {
      setState(() {
        //print(result.toString());
        _selectedTime = result.toString().substring(10, 15);
      });
    } else {
      setState(() {
        _selectedTime = "00:00";
      });
    }
  }

  //Alert box
  Future showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = Expanded(
        child: ElevatedButton(
      style:
          ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 0),
      child: Text(
        "Discard changes",
        style: GoogleFonts.poppins(
            color: Color(0xff4750d5),
            fontWeight: FontWeight.w400,
            fontSize: 12),
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context, false);
      },
    ));
    Widget continueButton = Expanded(
        child: ElevatedButton(
      style:
          ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 0),
      child: Text(
        "Save changes",
        style: GoogleFonts.poppins(
            color: Color(0xff4750d5),
            fontWeight: FontWeight.w400,
            fontSize: 12),
      ),
      onPressed: () {
        //print(isEdit);
        print(noteId);
        if (isEdit == true) {
          patchData(myController.text, _selectedTime.toString(), noteId!);
          Navigator.pop(context);
          Navigator.pop(context, true);
        } else {
          Navigator.pop(context);
          dataCheck();
        }
        // Navigator.pop(context,true);
      },
    ));
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text("Save Changes?",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black)),
      content: Text(
        'Want to save the changes',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
      ),
      actions: [
        Row(
          children: [cancelButton, continueButton],
        )
      ],
    );
    // show the dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<AddNote?> patchData(
      String description, String time, int noteId) async {
    var datetime = (DateTime.now().toUtc().millisecondsSinceEpoch) ~/ 1000;
    var url = "http://194.163.145.243:9007/api/notes/${noteId.toString()}";
    int hours = int.parse(time.split(":")[0]);
    int minutes = int.parse(time.split(":")[1]);
    int totalTime = hours * 60 + minutes;
    final response = await http.patch(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "NoteText": description,
        "TimeTracking": totalTime,
        "DateSubmitted": datetime,
      }),
    );
    if (response.statusCode == 200) {
      print(description);
      print(totalTime);
      print(response.body);
    } else {
      Navigator.pop(context, false);
      throw Exception('Failed to update data' + response.statusCode.toString());
    }
  }

  Future<AddNote?> postData(String description, String time) async {
    var datetime = (DateTime.now().toUtc().millisecondsSinceEpoch) ~/ 1000;
    if (!functionCalled && time == "00:00") {
      time = "00:00";
    }
    print(datetime);
    print(model.ticketID);
    int hours = int.parse(time.split(":")[0]);
    int minutes = int.parse(time.split(":")[1]);
    int totalTime = hours * 60 + minutes;
    print(description);
    print(totalTime);
    final response = await http.post(
      Uri.parse('http://194.163.145.243:9007/api/notes/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'TicketId': model.ticketID,
        'NoteText': description,
        'ReporterId': model.reportedID,
        'TimeTracking': totalTime,
        'DateSubmitted': datetime,
      }),
    );
    print(model.reportedID);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return AddNote.fromJson(jsonDecode(response.body));
    } else {
      // Navigator.pop(context);
      Navigator.pop(context, false);
      throw Exception(
          'Failed to create album.' + response.statusCode.toString());
    }
  }

  void dataCheck() {
    if (myController.text == "") {
      Fluttertoast.showToast(msg: "Please enter description");
    }
    if (myController.text != "") {
      postData(myController.text, _selectedTime.toString());
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Add Note",
          style: GoogleFonts.poppins(
              fontSize: 18,
              color: Color(0xff4750d5),
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, elevation: 0),
          onPressed: () {
            showAlertDialog(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Color(0xff4750d5),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.only(
                    left: devWidth * 0.04,
                    right: devWidth * 0.04,
                    top: devHeight / 40),
                height: devHeight * 0.22,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 25),
                  child: TextField(
                    controller: myController,
                    maxLines: null,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Description',
                        hintStyle: GoogleFonts.poppins(
                            color: Color(0xFF6C6F93),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        border: InputBorder.none),
                  ),
                )),
            Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 25,
                        top: MediaQuery.of(context).size.height / 65),
                    height: MediaQuery.of(context).size.height / 12,
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 22.5),
                        child: Text(
                          'Worked hours',
                          style: GoogleFonts.poppins(
                              color: Color(0xFF6C6F93),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ))),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.only(
                      right: devWidth * 0.04,
                      left: devWidth * 0.03,
                      top: devHeight / 65),
                  height: devHeight / 12,
                  width: devWidth / 2.2,
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            _show();
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: devWidth / 22.5),
                                child: Text(
                                  _selectedTime.toString(),
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff4750d5),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: devWidth / 8.5),
                                child: const Icon(
                                  Icons.timer,
                                  color: Color(0xff4750d5),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              width: devWidth / 1.1,
              height: devHeight / 12,
              margin: EdgeInsets.only(top: devHeight / 2.85),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4750d5)),
                child: Text('Submit',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                onPressed: () {
                  if (isEdit == true) {
                    patchData(
                        myController.text, _selectedTime.toString(), noteId!);
                    Navigator.pop(context, true);
                  } else {
                    dataCheck();
                  }
                },
                // color: Color(0xff4750d5),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 1,
      ),
    );
  }
}
