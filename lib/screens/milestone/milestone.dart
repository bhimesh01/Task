import 'dart:convert';
import 'dart:developer';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:task/screens/milestone/milestonecontainer.dart';
import 'package:task/screens/reusableWidgets/customAppBar.dart';
import 'package:task/screens/reusableWidgets/customBottomNavBar.dart';
import 'package:task/screens/view/view.dart';
import 'package:http/http.dart' as http;

import '../dashboard/assigned.dart';
class Milestone extends StatefulWidget {
  const Milestone({Key? key}) : super(key: key);
  @override
  MilestoneState createState() => MilestoneState();
}
List<dynamic> milestones = [];
class MilestoneState extends State<Milestone> {
  bool loadSpinner = true;
  int currPage =1;
  Future<dynamic> getMilestone() async{

    String url = "http://194.163.145.243:9007/api/milestone/${prModel.projectID}/$currPage";
    print(url);
    Future.delayed(Duration.zero, () {
      setState(() {
        url =
        "http://194.163.145.243:9007/api/milestone/${prModel.projectID}/$currPage";
      });
    });
    var feedback = await http.get(Uri.parse(url));
    if(feedback.statusCode==200){
      if (jsonDecode(feedback.body).isEmpty) {
        setState(() {
          loadSpinner = false;
        });
      } else {
        setState(() {
          milestones.addAll(jsonDecode(feedback.body));
        });
      }
      print(milestones.length);
    }else{
      setState(() {
        milestones = [];
      });
      Fluttertoast.showToast(msg: 'Error fetching data');
    }
    }


  void initState(){
    super.initState();
    getMilestone();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            currPage = 1;
            milestones = [];
            getMilestone();
          });
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: (milestones.isEmpty)
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
                    itemCount: milestones.length,
                    itemBuilder: ((context, index) {
                      return MilestoneContainer(
                        startdate: milestones[index]['startDate'].toString(),
                        enddate: milestones[index]['endDate'].toString(),
                        week: milestones[index]['milestone'].toString(),
                      );
                    })),
                Container(
                  child: TextButton(
                    child: Text('Load More..'),
                    onPressed: () {
                      print(url);
                      setState(() {
                        currPage += 1;
                      });
                      Future.delayed(Duration.zero, () => getMilestone());
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
