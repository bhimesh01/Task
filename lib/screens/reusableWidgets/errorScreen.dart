import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Oops!',
            style: TextStyle(color: Colors.grey, fontSize: 25),
          ),
          Image.asset(
            'assets/images/errorImage.png',
            width: devWidth / 2.0,
            height: devHeight / 2.0,
          ),
          Padding(
            child: Text(
              'Sorry, Data not found :(',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            padding: EdgeInsets.only(bottom: 40),
          ),
        ],
      ),
    );
  }
}
