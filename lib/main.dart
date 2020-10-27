import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'myApp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

