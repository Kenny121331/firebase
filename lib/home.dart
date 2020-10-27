import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_exercise/EditProfile.dart';
import 'package:flutter_app_exercise/LogIn.dart';
import 'package:flutter_app_exercise/schoolBusiness.dart';
import 'package:intl/intl.dart';

import 'checkInfor.dart';
import 'chooseAccount.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name;
  String formattedDate = DateFormat('kk:mm \n EEE d MMM').format(DateTime.now());
  int _selectedIndex = 0;
  Widget column(){
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
      ],
    );
  }
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  static List<Widget> _WIDGET_OPTION = <Widget>[
    CheckInfor(),
    ChooseBusiness(),
    Text(
        'Index 2: School',
      style: TextStyle(color: Colors.red, fontSize: 40),
    ),
    ChooseAccount()
  ];
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
      if (index == 0){
        setState(() {
          name = 'Home';
        });
      } else if (index == 1) {
        setState(() {
          name = 'Business';
        });
      } else if (index == 2) {
        setState(() {
          name = 'School';
        });
      } else if (index == 3) {
        setState(() {
          name = 'Account';
        });
      }
    });
  }

  Future<void> _check () async {
    FirebaseFirestore.instance
        .collection('users')
        .doc('WtPMQ8uKLXKfS8tyOKV0')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        print(documentSnapshot.data().values.toList().length);
        print(documentSnapshot.data().values.toList());
        print(documentSnapshot.data().values.toList()[3]);
        documentSnapshot.data().forEach((key, value) {
          print(value);
        });
      } else { print('Document don\'t exist on the database');}
    });
  }


  final GlobalKey<ScaffoldState> _scafoldKey = new GlobalKey<ScaffoldState>();
  bool _choose = false;
  Widget text(String text){
    return Text(
      text,
      style: TextStyle(color: Colors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        leading: IconButton(
          icon: Icon(Icons.dehaze, color: Colors.indigo[800]),
          onPressed: () => _scafoldKey.currentState.openDrawer(),
        ),
        title: Center(
          child: Text(name??'Home', style: TextStyle(color: Colors.indigo[800])),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.indigo[800]),
          )
        ],
      ),
      body: Center(
        child: _WIDGET_OPTION.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black,),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business, color: Colors.black),
              title: Text('Business', ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school, color: Colors.black),
              title: Text('School'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Colors.black),
              title: Text('Account'),
            ),
          ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        backgroundColor: Colors.pink[100],
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        onPressed: (){},
        child: Icon(Icons.add, size: 40,),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/Suka.jpg'),
                  ),
                  Text(
                    'Tiffany', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                  )
                ],
              ),
            ),
            ListTile(
              onTap: (){},
              title: text('To-do'),
            ),
            ListTile(
              onTap: (){},
              title: text('Scheduler'),
            ),
            ListTile(
              onTap: (){},
              title: text('Notifications'),
            ),
            ListTile(
              onTap: (){},
              title: text('Profile'),
            ),
            ListTile(
              onTap: (){
                FirebaseAuth.instance.signOut().then((value){
                  Navigator.pushNamed(
                      context,
                      LogIn.ROUTER
                  );
                });
              },
              title: Text('Logout', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}



