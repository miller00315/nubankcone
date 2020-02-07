import 'package:drawer_app/src/resources/repository.dart';
import 'dart:async';
import '../bloc.dart';

class UserFinanceBloc implements Bloc {

  final Repository _repository = Repository();

  Future<void> signOut() => _repository.signOut();
  Future<String> getUserUID() => _repository.getUserUID();

  @override
  void dispose() {
    // TODO: implement dispose
  }
  
}