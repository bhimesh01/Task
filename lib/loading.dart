import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/screens/LoginScreens/login.dart';
import 'package:task/screens/body.dart';
import 'package:task/screens/dashboard/dashboard.dart';

import 'models/userModel.dart';

class Load extends StatefulWidget {
  const Load({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoadState();
  }
}

class LoadState extends State<Load> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => checkUserLogged());
  }

  void checkUserLogged() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('shouldLogin') == true) {
      if (prefs.getInt('expiry') != null) {
        int epoch = prefs.getInt('expiry')!;
        var dt = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
        print(dt);
        if (DateTime.now().isBefore(dt)) {
          // Fluttertoast.showToast(msg: 'Auth successful');
          model = UserModel(
              email: prefs.getString('email')!,
              userID: prefs.getInt('userId')!,
              username: prefs.getString('username')!,
              statusCode: prefs.getInt('statusCode')!);
          Future.delayed(
              Duration.zero,
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => MainBody(
                      index: 0,
                    ),
                  )));
        } else {
          // Fluttertoast.showToast(msg: 'Auth error!');
          prefs.clear();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Login()));
        }
      }
    } else {
      //bruh
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5FA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Padding(
              padding: EdgeInsets.only(top: 16),
            ),
            Image.asset(
              "assets/images/loadingImage.png",
              height: 140,
              width: 144,
            ),
            SizedBox(height: 40),
            Text(
              "TASK",
              style: GoogleFonts.montserrat(
                  fontSize: 38,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff1D1E30)),
            ),
            SizedBox(
              height: 40,
            ),
            CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4750D5))),
            Spacer(),
            Text("@copyright",
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff858585))),
            Padding(
              padding: EdgeInsets.only(bottom: 16),
            )
          ],
        ),
      ),
    );
  }
}
