import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthenticationResources {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<FirebaseUser> get onAuthStateChange => _firebaseAuth.onAuthStateChanged;

  Future<String> getUserUID() async {
    final FirebaseUser _user = await _firebaseAuth.currentUser();
    return _user.uid;
  }

  Future<int> loginWithEmailAndPassword(String email, String password) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return 1;

    } on PlatformException catch(e){
      print('Platform excption ${e.toString()}');
      return -1;
    } catch(e) {
      print('Exception autehtication ${e.toString()}');
      return -2;
    }
  }

  Future<int> signUpWithEmailAndPassword(String email, String password, String name) async {
    try {
      AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      await setUserDisplayName(authResult.user, name);

      return 1;

    } on PlatformException catch(e){
      print('Platform excption ${e.toString()}');
      return -1;
    } catch(e) {
      print('Exception autehtication ${e.toString()}');
      return -2;
    }
  }

  Future<void> setUserDisplayName(FirebaseUser user, String displayName) async {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = displayName;
    await user.updateProfile(updateInfo);
  }

  Future<void> get signOut async {
    _firebaseAuth.signOut();
  }

}