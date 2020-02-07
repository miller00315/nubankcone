import 'package:drawer_app/src/bloc/bloc.dart';
import 'package:drawer_app/src/resources/repository.dart';
import 'package:drawer_app/src/utils/prefs.manager.dart';
import 'package:drawer_app/src/utils/validator.dart';
import 'package:drawer_app/src/utils/values/strings.constans.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc with Bloc {
  final _repository = Repository();
  final _email = BehaviorSubject<String>();
  final _displayName = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _isSignedIn = BehaviorSubject<bool>();

  Observable<String> get email => _email.stream.transform(_validateEmail);
  Observable<String> get password => _password.stream.transform(_validatePassword);
  Observable<String> get displayName => _displayName.stream.transform(_validateDisplayName);
  Observable<bool> get signInStatus => _isSignedIn.stream;

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changeDisplayName => _displayName.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(bool)   get showProgressBar => _isSignedIn.sink.add;

  //validations

  final _validateDisplayName = StreamTransformer<String, String>.fromHandlers(
    handleData: (displayName, sink) {
      if(displayName.length > 5) {
        sink.add(displayName);
      } else {
        sink.addError(StringConstants.displayNameValidateMessage);
      }
    }
  );

  final _validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if(Validator.validatePassword(password)) {
        sink.add(password);
      } else {
        sink.addError(StringConstants.passwordValidateMessage);
      }
  });

  final _validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
        if(Validator.validateEmail(email)) {
          sink.add(email);
        } else {
          sink.addError(StringConstants.emailValidateMessage);
        }
      });

  bool validateEmailAndPassword() {
    print(_email.value);
    print(_password.value);
    if(
      _email.value != null &&
      _email.value.isNotEmpty &&
      _email.value.contains('@') &&
      _password.value != null &&
      _password.value.isNotEmpty &&
      _password.value.length > 5
    ) {
      
      return true;
    }
    return false;
  }

  void saveCurrentUserDisplayName(SharedPreferences prefs) {
    PrefsManager prefsManager = PrefsManager();
    prefsManager.setCurrentUserDisplayName(prefs, _displayName.value);
  }

  bool validateDisplayName() {
    return _displayName.value != null && _displayName.value.isNotEmpty && _displayName.value.length > 5;
  }

  //firebase methods

  Future<int> loginUser() async {
    showProgressBar(true);
    int response = await _repository.loginWithEmailAndPassword(_email.value, _password.value);
    showProgressBar(false);
    return response;
  }

  Future<int> registerUser() async {
      showProgressBar(true);
      int response = await _repository.signUpWithEmailAndPassword(_email.value, _password.value, _displayName.value);
      showProgressBar(false);
      return response;
  }

  @override
  void dispose() async {
    await _email.drain();
    _email.close();
    await _password.drain();
    _password.close();
    await _displayName.drain();
    _password.close();
    await _isSignedIn.drain();
    _isSignedIn.close();
  }
}
