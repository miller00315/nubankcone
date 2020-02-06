import 'dart:ui';

import 'package:drawer_app/pages/login/widgets/form.field.main.dart';
import 'package:flutter/material.dart';
import 'package:drawer_app/src/utils/values/colors.dart';

const double min_height = 60.0;
const double max_height = 450.0;
const double min_width = 250.0;
const double max_width = 400;
const double min_bottom_button_margin = 15.0;
const double max_bottom_button_margin = -150.0;
const double max_forms_container_margin = 80;
const double min_forms_container_margin = 10;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
  }

  AnimationController _controller;

  bool _loginContainerOpened = false;
  bool _signUpContainerOpened = false;

  double _formContainerMargin = max_forms_container_margin;

  double _signUpContainerHeight = min_height;
  double _signUpContainerWidth = min_width;

  double _loginContainerHeight = min_height;
  double _loginContainerWidth = min_width;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _scaledDownSignUpButton() {
    if (_signUpContainerOpened) {
      _signUpContainerHeight = min_height;
      _signUpContainerWidth = min_width;
      _signUpContainerOpened = false;
    }
  }

  void _scaledDownLoginButton() {
    if (_loginContainerOpened) {
      _loginContainerHeight = min_height;
      _loginContainerWidth = min_width;
      _loginContainerOpened = false;
    }
  }

  void _toggleAuthButtomScale(bool isLogin) {
    setState(() {
      if (isLogin) {
        _loginContainerHeight =
            _loginContainerHeight == max_height ? min_height : max_height;
        _loginContainerWidth =
            _loginContainerWidth == max_width ? min_width : max_width;
        _scaledDownSignUpButton();
        _loginContainerOpened = !_loginContainerOpened;
      } else {
        _signUpContainerHeight =
            _signUpContainerHeight == max_height ? min_height : max_height;
        _signUpContainerWidth =
            _signUpContainerWidth == max_width ? min_width : max_width;
        _scaledDownLoginButton();
        _signUpContainerOpened = !_signUpContainerOpened;
      }

      _formContainerMargin = _formContainerMargin == min_forms_container_margin
          ? max_forms_container_margin
          : min_forms_container_margin;
    });
  }

  void _toggleNulogoAndGoogleButton() {
    final bool isAnyContainerAnimationCompleted =
        _controller.status == AnimationStatus.completed;

    _controller.fling(velocity: isAnyContainerAnimationCompleted ? -2 : 2);
  }

  double lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: ColorConstant.colorMainPurple,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return (Positioned.fill(
                top: lerp(min_bottom_button_margin, max_bottom_button_margin),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(top: 50),
                        child: Image.asset(
                          'assets/images/nulogo.png',
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(top: 10, bottom: 5),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ));
            },
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
                margin: EdgeInsets.only(top: _formContainerMargin),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AnimatedSwitcher(
                        child: _loginContainerOpened
                            ? Container()
                            : GestureDetector(
                                onTap: () {
                                  if (!_loginContainerOpened &&
                                      !_signUpContainerOpened) {
                                    _toggleAuthButtomScale(false);
                                    _toggleNulogoAndGoogleButton();
                                  }
                                },
                                child: AnimatedContainer(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      top: _formContainerMargin),
                                  width: _signUpContainerWidth,
                                  height: _signUpContainerHeight,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    child: _signUpContainerOpened
                                        ? Container(
                                            alignment: Alignment.center,
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned(
                                                  top: 5.0,
                                                  left: 5.0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (_signUpContainerOpened) {
                                                        _toggleAuthButtomScale(
                                                            false);
                                                        _toggleNulogoAndGoogleButton();
                                                      }
                                                    },
                                                    child: Icon(Icons.close,
                                                        size: 40),
                                                  ),
                                                ),
                                                Positioned.fill(
                                                  top: 70,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      children: <Widget>[
                                                        //Form Fields
                                                        FormFieldMain(
                                                          hintText: '..Email',
                                                          onChange: (value) {},
                                                          marginRight: 20,
                                                          marginLeft: 20,
                                                          marginTop: 0,
                                                          textInputType:
                                                              TextInputType
                                                                  .emailAddress,
                                                          obscured: false,
                                                          key: Key('email'),
                                                        ),
                                                        FormFieldMain(
                                                          hintText:
                                                              '..Password',
                                                          onChange: (value) {},
                                                          marginRight: 20,
                                                          marginLeft: 20,
                                                          marginTop: 10,
                                                          textInputType:
                                                              TextInputType
                                                                  .emailAddress,
                                                          obscured: true,
                                                          key: Key('password'),
                                                        ),
                                                        FormFieldMain(
                                                          hintText:
                                                              '..Name user',
                                                          onChange: (value) {},
                                                          marginRight: 20,
                                                          marginLeft: 20,
                                                          marginTop: 10,
                                                          textInputType:
                                                              TextInputType
                                                                  .emailAddress,
                                                          obscured: false,
                                                          key: Key('name'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned.fill(
                                                  bottom: 15,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        margin: EdgeInsets.only(
                                                            left: 30,
                                                            right: 30),
                                                        height: 60,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          border: Border.all(
                                                            color: ColorConstant
                                                                .colorMainPurple,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'Register',
                                                          style: TextStyle(
                                                            color: ColorConstant.colorMainPurple,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 25,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Text(
                                            'Sign up',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 25,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                        duration: Duration(milliseconds: 200),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AnimatedSwitcher(
                        child: _signUpContainerOpened
                            ? Container()
                            : GestureDetector(
                                onTap: () {
                                  if (!_signUpContainerOpened &&
                                      !_loginContainerOpened) {
                                    _toggleAuthButtomScale(true);
                                    _toggleNulogoAndGoogleButton();
                                  }
                                },
                                child: AnimatedContainer(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      top: 0),
                                  width: _loginContainerWidth,
                                  height: _loginContainerHeight,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    child: _loginContainerOpened
                                        ? Container(
                                            alignment: Alignment.center,
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned(
                                                  top: 5.0,
                                                  left: 5.0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (_loginContainerOpened) {
                                                        _toggleAuthButtomScale(
                                                            true);
                                                        _toggleNulogoAndGoogleButton();
                                                      }
                                                    },
                                                    child: Icon(Icons.close,
                                                        size: 40),
                                                  ),
                                                ),
                                                Positioned.fill(
                                                  top: 70,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      children: <Widget>[
                                                        //Form Fields
                                                        FormFieldMain(
                                                          hintText: '..Email',
                                                          onChange: (value) {},
                                                          marginRight: 20,
                                                          marginLeft: 20,
                                                          marginTop: 0,
                                                          textInputType:
                                                              TextInputType
                                                                  .emailAddress,
                                                          obscured: false,
                                                          key: Key('email'),
                                                        ),
                                                        FormFieldMain(
                                                          hintText:
                                                              '..Password',
                                                          onChange: (value) {},
                                                          marginRight: 20,
                                                          marginLeft: 20,
                                                          marginTop: 10,
                                                          textInputType:
                                                              TextInputType
                                                                  .emailAddress,
                                                          obscured: true,
                                                          key: Key('password'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned.fill(
                                                  bottom: 15,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        margin: EdgeInsets.only(
                                                            left: 30,
                                                            right: 30),
                                                        height: 60,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          border: Border.all(
                                                            color: ColorConstant
                                                                .colorMainPurple,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'Login',
                                                          style: TextStyle(
                                                            color: ColorConstant.colorMainPurple,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 25,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Text(
                                            'Login',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 25,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                        duration: Duration(milliseconds: 200),
                      ),
                    ]),
              ),
            ],
          ),
          AnimatedBuilder(
            builder: (context, child) {
              return Positioned.fill(
                bottom:
                    lerp(min_bottom_button_margin, max_bottom_button_margin),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      height: 55,
                      width: 55,
                      child: ClipOval(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Image.asset('assets/images/googleicon.png'),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            animation: _controller,
          ),
        ],
      ),
    );
  }
}
