import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr/qr.dart';

import 'bibs.dart';

class Home extends StatefulWidget {
  Home({this.user});
  final FirebaseUser user;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int scherm = 0;
  List<Widget> schermen = <Widget>[
    Bibs(),
    Text('Scherm 2'),
    Text('Scherm 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buivr'),
        actions: <Widget>[
          CircleAvatar(
            radius: 25,
            child: ClipOval(child: Image.network(widget.user.photoUrl)),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: scherm,
        onTap: (value) {
          setState(() {
            scherm = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_library),
            title: Text('Bibs'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Colleges'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account'),
          )
        ],
      ),
      body: schermen[scherm],
    );
  }
}
