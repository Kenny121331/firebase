import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChooseBusiness extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth user = FirebaseAuth.instance;
  DateTime time = DateTime.now();
  _check() {
    print(time.weekday);
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        color: Colors.blue,
        onPressed: _check,
        child: Text(
            'Check'
        ),
      ),
    );
  }
}

