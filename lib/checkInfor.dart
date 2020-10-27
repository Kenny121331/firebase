import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_exercise/LogIn.dart';

class CheckInfor extends StatelessWidget {

  Future<void> _check () async {
    var result = await FirebaseFirestore.instance
        .collection('users')
        .where('age', isGreaterThan: 20)
        .get();
    print('Check');
    result.docs.forEach((element) {
      print('Check2');
      print(element.data().length);
      print(element.data().values.toList());
      print(element.data().values.toList()[3]);
      print(element.data()['name']);
      element.data().forEach((key, value) {
        print(value);
      });
    });
  }
  Future<void> _check2 () async{
    FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: 'Vân')
        .get()
        .then((QuerySnapshot querySnapshot){
      querySnapshot.docs.forEach((doc) {
        print(doc.data());
        print(doc.data().values.toList());
        print(doc.data()['sex']);
        print(doc.data().values.toList()[4]);
        doc.data().forEach((key, value) {
          print(value);
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Index 0: Home',
          style: TextStyle(color: Colors.black, fontSize: 40),
        ),
        Text(
          'Index 1: Business',
          style: TextStyle(color: Colors.blue, fontSize: 40),
        ),
        Text(
          'check check',
          style: TextStyle(color: Colors.blue, fontSize: 40),
        ),
        Text(
          'check check',
          style: TextStyle(color: Colors.blue, fontSize: 40),
        ),
        RaisedButton(
          color: Colors.red,
          onPressed: _check,
          child: Text('Check'),
        ),
        RaisedButton(
          color: Colors.red,
          onPressed: _check2,
          child: Text('Check2'),
        ),
        RaisedButton(
          color: Colors.red,
          onPressed: (){},
          child: Text('Change password'),
        ),
        RaisedButton(
          color: Colors.red,
          onPressed: (){
            FirebaseAuth.instance.signOut().then((_){
              Navigator.pushNamed(context, LogIn.ROUTER);
            });
          },
          child: Text('Log out'),
        ),
      ],
    );
  }
}