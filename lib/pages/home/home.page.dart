import 'package:drawer_app/src/bloc/user_finance/user.finance.bloc.dart';
import 'package:drawer_app/src/bloc/user_finance/user.finance.bloc.provider.dart';
import 'package:drawer_app/src/utils/values/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "HomePage";
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    _userFinanceBloc = UserFinanceBlocProvider.of(context);
    super.didChangeDependencies();
  }

  UserFinanceBloc _userFinanceBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorMainPurple,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: GestureDetector(
          onTap: () => this._userFinanceBloc.signOut(),
          child: Text('Home page',
              style: TextStyle(color: Colors.white, fontSize: 40)),
        ),
      ),
    );
  }
}
