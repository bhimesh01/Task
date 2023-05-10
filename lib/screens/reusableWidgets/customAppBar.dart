import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/models/projectModel.dart';
import 'package:task/screens/body.dart';
import 'package:task/screens/dashboard/assigned.dart';
import 'package:task/screens/dashboard/reported.dart';
import 'package:task/screens/reusableWidgets/customBottomNavBar.dart';
import 'package:task/screens/reusableWidgets/menu.dart';
import 'package:task/screens/LoginScreens/login.dart';
import 'package:http/http.dart' as http;
import 'package:task/screens/view/view.dart';

import '../dashboard/dashboard.dart';

String buttonText = '';
ProjectModel prModel = ProjectModel(projectID: -1, projectName: '');
String url = "http://194.163.145.243:9007/api/projectlist/${model.userID}";

List<dynamic> projects = [];

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  MyAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;
  @override
  _myAppBarState createState() => _myAppBarState();
}

Widget dropDownDialogContainer(
    BuildContext context, List<dynamic> projectList) {
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.separated(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: projectList.length,
            separatorBuilder: (BuildContext context, index) {
              return Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  projectList[index]['projectName'],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: Color(0xff2C35BF),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                onTap: () {
                  Navigator.pop(context, index);
                },
              );
            })
      ],
    ),
  );
}

class _myAppBarState extends State<MyAppBar> {
  void getProjectsFromAPI() {
    var response = http.get(Uri.parse(url));
    response.then(
      (value) => {
        setState(() {
          print(jsonDecode(value.body));
          projects = jsonDecode(value.body);
          buttonText = projects[0]['projectName'];
          prModel = ProjectModel(
              projectID: projects[0]['projectId'],
              projectName: projects[0]['projectName']);
          print(prModel.projectID);
        }),
      },
    );
  }

  void initState() {
    if (projects.length == 0) {
      getProjectsFromAPI();
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.all(13),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => Menu())));
          },
          child: Image.asset("assets/icons/menuIcon.png"),
        ),
      ),
      title: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  buttonText,
                  style: GoogleFonts.poppins(
                      color: Color(0xff2C35BF),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Image.asset(
                    'assets/icons/arrowSide.png',
                    width: 12,
                    height: 12,
                  ),
                ),
              ],
            ),
            onTap: () async {
              if (projects.isEmpty) {
                //ensures API is called only once.
                getProjectsFromAPI();
              } else {
                await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        alignment: Alignment.center,
                        child: dropDownDialogContainer(context, projects),
                      );
                    }).then((valuefromDiag) {
                  if (valuefromDiag == null) {
                    //used to handle null value check in DropDownMenu
                  } else {
                    setState(() {
                      buttonText = projects[valuefromDiag]['projectName'];
                      if (buttonText != prModel.projectName) {
                        prModel = ProjectModel(
                            projectID: projects[valuefromDiag]['projectId'],
                            projectName: projects[valuefromDiag]
                                ['projectName']);

                        if (manager.bottomNavBarIndex == 0) {
                          setState(() {
                            assignedTickets = [];
                            reportedTickets = [];
                          });
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MainBody(
                                key: UniqueKey(),
                                index: 0,
                              ),
                            ),
                          );
                        }
                        if (manager.bottomNavBarIndex == 1) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MainBody(
                                key: UniqueKey(),
                                index: 1,
                              ),
                            ),
                          );
                        }
                        print(prModel.projectID);
                        print(prModel.projectName);
                      }
                    });
                  }
                });
              }
            }),
      ),
    );
  }
}
