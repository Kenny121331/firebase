import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_exercise/LogIn.dart';
import 'package:flutter_app_exercise/schoolBusiness.dart';

class Register extends StatefulWidget {
  static final ROUTER = '/Register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth user = FirebaseAuth.instance;
  String _errorString;
  bool _error = false;
  bool _eye = true;
  bool _eyeCheck = true;
  String _email, _password, _passwordCheck;
  Future<void> _createUser() async{
    if (_password != _passwordCheck) {
      setState(() {
        _error = true;
      });
      _errorString = 'Password incorrect';
      _error = false;
    } else {
      try {
        print('Email: $_email  Password: $_password');
        UserCredential userCredential = await FirebaseAuth
            .instance
            .createUserWithEmailAndPassword(email: _email, password: _password).then((value){
              _addUser();
              return null;
        });
        print('User: $userCredential');
      } on FirebaseAuthException catch (e) {
        print('Error: $e');
      } catch (e) {
        print('Error: $e');
      }
      return Navigator.pushNamed(
          context,
          LogIn.ROUTER
      );
    }
  }
  void _addUser(){
    users.doc(user.currentUser.uid).set({
      'email' : user.currentUser.email,
      'settings' : {
        'GetEmailNotifications' : false,
        'VibrateOnAlert' : false,
        'ShareProfileWithOtherFlossUsers' : false,
        'ShowYourTaskCompletionStatus' : false,
        'SaveAsAlarm' : false,
        'ShowAsNotification' : false
      },
    }).then((value) => Navigator.pushNamed(context, LogIn.ROUTER))
    ;
  }

  //FirebaseAuth auth = FirebaseAuth.instance;

  void _toggleEye(){
    setState(() {
      _eye = ! _eye;
    });
  }
  void _toggleEyeCheck(){
    _eyeCheck = ! _eyeCheck;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        leading: null,
        backgroundColor: Colors.pink[100],
        elevation: 0,
        title: Center(
          child: Text(
            'Register', style: TextStyle(fontSize: 21, color: Colors.indigo[800]),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Email', style: TextStyle(color: Colors.blue),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: TextField(
                  onChanged: (text) {
                    _email = text;
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(20)
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(20)
                        ),
                      )
                  ),
                ),
              ),
              Text(
                'Password', style: TextStyle(color: Colors.blue),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                  ),
                  //color: Colors.white,
                  child: TextField(
                    onChanged: (text){
                      _password = text;
                    },
                    obscureText: _eye,
                    decoration: InputDecoration(
                        errorText: _error ? _errorString : null,
                        suffixIcon: IconButton(
                          icon: Icon(_eye ? Icons.visibility_off : Icons.visibility),
                          onPressed: _toggleEye,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(20)
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(20)
                          ),
                        )
                    ),
                  ),
                ),
              ),
              Text(
                'Confirm Password', style: TextStyle(color: Colors.blue),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 30),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                  ),
                  //color: Colors.white,
                  child: TextField(
                    onChanged: (text){
                      _passwordCheck = text;
                    },
                    obscureText: _eyeCheck,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_eyeCheck ? Icons.visibility_off : Icons.visibility),
                          onPressed: _toggleEyeCheck,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(20)
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(20)
                          ),
                        )
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: _createUser,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text(
                    'Register', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                width: double.infinity,
                height: 50,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'By registering, you automatically', style: TextStyle(color: Colors.blue),
                      ),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'accept the ', style: TextStyle(color: Colors.blue)),
                            TextSpan(text: 'Terms & Policies', style: TextStyle(
                                color: Colors.blue, fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline
                            ),
                              recognizer: TapGestureRecognizer()..onTap = (){}
                            ),
                            TextSpan(text: ' of', style: TextStyle(color: Colors.blue)),
                          ]
                        ),
                      ),
                      Text(
                        'candy app.', style: TextStyle(color: Colors.blue),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(
                              context,
                              LogIn.ROUTER
                            );
                          },
                          child: Text(
                            'Have account? Log In',
                            style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
