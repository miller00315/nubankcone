

import 'package:drawer_app/src/bloc/authentication/authentication.bloc.dart';
import 'package:flutter/material.dart';

class AuthenticationBlocProvider extends InheritedWidget{
  static final bloc = AuthenticationBloc();

  AuthenticationBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static AuthenticationBloc of(BuildContext context) {
    return AuthenticationBlocProvider.bloc;
  }
}