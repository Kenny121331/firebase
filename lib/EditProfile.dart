import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_exercise/LogIn.dart';

class EditProfile extends StatelessWidget {
  static final ROUTER = '/Editprofile';
  @override
  Widget build(BuildContext context) {
    String _newEmail;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth user = FirebaseAuth.instance;
    Future<void> _changeEmail() async {
      user.currentUser.updateEmail(_newEmail)
          .then((value){
         users.doc(user.currentUser.uid)
         .update({
           'email' : _newEmail
         }).then((value){
           showDialog<void>(
             context: context,
             barrierDismissible: false, // user must tap button!
             builder: (BuildContext context) {
               return AlertDialog(
                 title: Text('Announce'),
                 content: SingleChildScrollView(
                     child: Text('Email changed. \nPlease login again')
                 ),
                 actions: <Widget>[
                   RaisedButton(
                     color: Colors.green,
                     child: Text('Ok'),
                     onPressed: (){
                       user.signOut().then((value) => Navigator.pushNamed(context, LogIn.ROUTER));
                     },
                   ),
                 ],
               );
             },
           );
         });
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: Text('Edit Profile', style: TextStyle(color: Colors.indigo[700]),),
        leading: Icon(Icons.account_circle, color: Colors.indigo[700], size: 40,)
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.pink[100],
            width: double.infinity,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 20),
              child: Text(
                'Full Name….',
                style: TextStyle(color: Colors.grey, fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('New Email'),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    onChanged: (text) {
                      _newEmail = text;
                    },
                    decoration: InputDecoration(
                      hintText: 'john@email.com',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(20)
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(20)
                          ),
                        )
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _changeEmail,
        child: Icon(Icons.check, color: Colors.white, size: 40,),
        backgroundColor: Colors.indigo[900],
      ),
    );
  }
}
