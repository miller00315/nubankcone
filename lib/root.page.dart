import 'package:drawer_app/pages/home/home.page.dart';
import 'package:drawer_app/pages/login/login.page.dart';
import 'package:drawer_app/src/resources/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  static const String routeName = "RootPage";
  @override
  _RootPageState createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();

    _currentUser = _repository.onAuthStateChange;
  }

  final Repository _repository = Repository();
  Stream<FirebaseUser> _currentUser;
 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: _currentUser,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        return snapshot.hasData ? HomePage() : LoginPage();
      },
    );
  }
}