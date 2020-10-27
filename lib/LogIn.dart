import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_exercise/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_exercise/splash.dart';

class LogIn extends StatefulWidget {
  static final ROUTER = '/Login';
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _eye = true;
  String _email, _password;

  void _toggleEye(){
    setState(() {
      _eye = ! _eye;
    });
  }

  Future<void> _loginUser() async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen())
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user - not - found') {
        print('No user found for that email');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.pink[100],
        appBar: AppBar(
          leading: null,
          backgroundColor: Colors.pink[100],
          elevation: 0,
          title: Center(
            child: Text(
              'LOGIN', style: TextStyle(fontSize: 21, color: Colors.indigo[800]),
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
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                    ),
                    child: TextField(
                      onChanged: (text){
                        _email = text;
                      },
                      decoration: InputDecoration(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Password', style: TextStyle(color: Colors.blue),
                    ),
                    Text(
                      'Forgot?', style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline),
                    ),
                  ],
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
                        _password = text;
                      },
                      obscureText: _eye,
                      decoration: InputDecoration(
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
                SizedBox(
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: _loginUser,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text(
                      'Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  width: double.infinity,
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(
                          context,
                          Register.ROUTER
                        );
                      },
                      child: Text(
                        'New User? Register Here',
                        style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
