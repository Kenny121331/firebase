import 'package:flutter/material.dart';
import 'package:flutter_app_exercise/EditProfile.dart';
import 'package:flutter_app_exercise/LogIn.dart';
import 'package:flutter_app_exercise/register.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Register.ROUTER: (context) => Register(),
        LogIn.ROUTER: (context) => LogIn(),
        EditProfile.ROUTER: (context) => EditProfile(),
      },
      home: LogIn(),
    );
  }
}
