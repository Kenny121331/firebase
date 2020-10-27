import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_exercise/EditProfile.dart';

class ChooseAccount extends StatefulWidget {
  @override
  _ChooseAccountState createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {
  var changeGettings = {};
  bool _getEmailNotifications;
  bool _vibrateOnAlert;
  bool _shareProfile;
  bool _showStatus;
  FirebaseAuth user = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Widget _choose(String text,String name, bool choose){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(text, style: TextStyle(fontSize: 16),),
        Switch(
          value: choose,
          onChanged: (value){
            _changeSettings(name, choose);
            setState(() {
              choose = value;
            });
          },
          activeColor: Colors.tealAccent,
          activeTrackColor: Colors.tealAccent,
        ),
      ],
    );
  }
  _changeSettings(String name, bool choose){
    print(name);
    print(changeGettings);
    changeGettings.forEach((key, value) {
      if (key == name){
        changeGettings[key] = !changeGettings[key];
      }
    });
    users
    .doc(user.currentUser.uid)
    .update({
      'settings' : changeGettings
    }).then((_){
      changeGettings.clear();
    }).then((value){
      getSettings();
    });
  }
  @override
  void initState() {
    getSettings();
    super.initState();
  }
  getSettings (){
    users
    .doc(user.currentUser.uid)
        .get()
        .then((value){
      changeGettings = value.data()['settings'];
      //print(changeGettings);
    });
  }

  @override
  Widget build(BuildContext context) {


    return Column(
      children: <Widget>[
        Container(
          color: Colors.pink[100],
          width: double.infinity,
          height: 120,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/Suka.jpg'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Tiffany', style: TextStyle(fontSize: 18),),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, EditProfile.ROUTER),
                      child: Text(user.currentUser.email,
                          style: TextStyle(fontSize: 18, decoration: TextDecoration.underline)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        FutureBuilder<DocumentSnapshot>(
            future: users.doc(user.currentUser.uid).get(),
            builder:
                (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              print(snapshot.connectionState);
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data()['settings'];
                _getEmailNotifications = data['GetEmailNotifications'];
                _vibrateOnAlert = data['VibrateOnAlert'];
                _shareProfile = data['ShareProfileWithOtherFlossUsers'];
                _showStatus = data['ShowYourTaskCompletionStatus'];
              }

              return Center(child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Notification Settings', style: TextStyle(color: Colors.grey)),
                      _choose('Get email notifications', 'GetEmailNotifications' , _getEmailNotifications),
                      _choose('Vibrate on alert', 'VibrateOnAlert' ,_vibrateOnAlert),
                      Text('Floss Settings', style: TextStyle(color: Colors.grey)),
                      _choose('Share profile with other floss users', 'ShareProfileWithOtherFlossUsers' , _shareProfile),
                      _choose('Show your task completion status', 'ShowYourTaskCompletionStatus' ,_showStatus),
                    ],
                  ),
                  snapshot.connectionState == ConnectionState.waiting ? Center(child: CircularProgressIndicator()): Container()
                ],
              ));
            }
        )
      ],
    );
  }
}