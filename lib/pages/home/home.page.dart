import 'package:drawer_app/src/utils/values/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "HomePage";
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorMainPurple,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Text('Home page',
            style: TextStyle(color: Colors.white, fontSize: 40)),
      ),
    );
  }
}
