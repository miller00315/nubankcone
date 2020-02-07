import 'package:drawer_app/pages/home/home.page.dart';
import 'package:drawer_app/pages/login/login.page.dart';
import 'package:drawer_app/root.page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     // home: LoginPage(),
      initialRoute: RootPage.routeName,
      routes: {
        RootPage.routeName: (context) => RootPage(),
        LoginPage.routeName: (context) => LoginPage(),
        HomePage.routeName: (context) => HomePage(),
      },
    );
  }
}

