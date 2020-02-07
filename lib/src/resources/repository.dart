import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawer_app/src/resources/authentication.resources.dart';
import 'package:drawer_app/src/resources/firestore.resources.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Repository {
  final _authResourses = AuthenticationResources();
  final _userFinacesResources = FirestoreResoucers();

  //Authentication
  Stream<FirebaseUser> get onAuthStateChange =>
      _authResourses.onAuthStateChange;
  Future<int> loginWithEmailAndPassword(String email, String password) =>
      _authResourses.loginWithEmailAndPassword(email, password);
  Future<int> signUpWithEmailAndPassword(
          String email, String password, String name) =>
      _authResourses.signUpWithEmailAndPassword(email, password, name);
  Future<void> signOut() => _authResourses.signOut;
  Future<String> getUserUID() => _authResourses.getUserUID();

  //Finaces Resources
  Stream<DocumentSnapshot> userFinancDoc(String userUID) =>
      _userFinacesResources.userFinancDoc(userUID);
  Future<void> setUserBudget(String userUID, double budget) =>
      _userFinacesResources.setUserBudget(userUID, budget);
  Future<void> addNewExpense(String userUID, double expenseValue) =>
      _userFinacesResources.addNewExpense(userUID, expenseValue);
  Stream<QuerySnapshot> expensesList(String userUID) =>
      _userFinacesResources.expensesList(userUID);
  Stream<QuerySnapshot> lastExpense(String userUID) =>
      _userFinacesResources.lastExpense(userUID);
}
