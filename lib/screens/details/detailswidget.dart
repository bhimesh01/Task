import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:task/screens/reusableWidgets/ticketContainer.dart';

class DetailsWidget extends StatelessWidget {
  String title;
  String statusState;
  String week;
  String time;
  String description;
  String repoUserName;
  String assignUserName;
  DetailsWidget(
      {Key? key,
      required this.title,
      required this.statusState,
      required this.week,
      required this.assignUserName,
      required this.description,
      required this.repoUserName,
      required this.time})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 28, right: 28, top: 20),
      child: Column(
        children: [
          TitleRow(context, title),
          Padding(
            padding: EdgeInsets.only(top: 24),
            child: StatusRow(context, statusState),
          ),
          Padding(
            padding: EdgeInsets.only(top: 17),
            child: WeekRow(context, week),
          ),
          Padding(
            padding: EdgeInsets.only(top: 17),
            child: timeRow(context, time),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: descriptionRow(context, description),
          ),
          UsernameRow(context, repoUserName, assignUserName)
        ],
      ),
    );
  }

  Widget TitleRow(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
        )
      ],
    );
  }

  Widget StatusRow(BuildContext context, String statusState) {
    return Row(
      children: [
        Icon(Icons.circle),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('$statusState'),
        )
      ],
    );
  }

  Widget WeekRow(BuildContext context, String week) {
    return Row(
      children: [
        Icon(Icons.flag_outlined, color: Color(0xff4750d5)),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('$week'),
        )
      ],
    );
  }

  Widget timeRow(BuildContext context, String time) {
    return Row(
      children: [
        Icon(
          Icons.timer_rounded,
          color: Color(0xff4750d5),
        ),
        Padding(padding: EdgeInsets.only(left: 10), child: Text('$time'))
      ],
    );
  }

  Widget descriptionRow(BuildContext context, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Description',
              style: TextStyle(
                  color: Color(0xff4750d5),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 15, right: 55),
          child: Container(
            // padding: EdgeInsetsGeometry.infinity,
            color: Color(0xFFE5E5E5),
            width: 304,
            height: 209,
            // margin: EdgeInsets.only(right: 28,),
            child: Text(
              '$description',
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

//   Widget TagsRow(BuildContext context,{
//
// }
  Widget UsernameRow(
      BuildContext context, String repoUserName, String assignUserName) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Reported by",
                style: TextStyle(color: Color(0xff4750d5)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 25, left: 20),
                child: Icon(Icons.circle),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(repoUserName),
              )
            ],
          ),
          Row(
            children: [
              Text(
                "Assigned to",
                style: TextStyle(color: Color(0xff4750d5)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 25, left: 20),
                child: Icon(Icons.circle),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(assignUserName),
              )
            ],
          ),
        ],
      ),
    );
  }
}
