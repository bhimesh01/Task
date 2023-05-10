import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/loading.dart';
import 'package:task/screens/LoginScreens/login.dart';
import 'package:task/screens/body.dart';
import 'package:task/screens/dashboard/dashboard.dart';
import 'package:task/screens/reusableWidgets/comingSoonScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      home: Load(),
    );
  }
}
