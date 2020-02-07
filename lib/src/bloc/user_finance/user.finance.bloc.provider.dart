import 'package:drawer_app/src/bloc/user_finance/user.finance.bloc.dart';
import 'package:flutter/material.dart';

class UserFinanceBlocProvider extends InheritedWidget {
  static final bloc = UserFinanceBloc();

  UserFinanceBlocProvider({Key key, Widget child}): super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;
  
  static UserFinanceBloc of(BuildContext context) {
    return UserFinanceBlocProvider.bloc;
  }
}