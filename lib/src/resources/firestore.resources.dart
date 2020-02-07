import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreResoucers {
  Firestore _firestore = Firestore.instance;

  Stream<DocumentSnapshot> userFinancDoc(String userID) =>
      _firestore.collection('userFinace').document(userID).snapshots();

  Future<void> setUserBudget(String userID, double budget) =>
      _firestore.collection('userFinance').document(userID).setData({
        'buget': budget,
      }, merge: true);

  Future<void> addNewExpense(String userID, double expenseValue) => _firestore
      .collection('userFinance')
      .document(userID)
      .collection('expenses')
      .document()
      .setData(
          {'value': expenseValue, 'timestamp': FieldValue.serverTimestamp()});

  Stream<QuerySnapshot> expensesList(String userID) => _firestore
    .collection('userFinance')
    .document(userID)
    .collection('expenses')
    .orderBy('timestamp', descending: true)
    .snapshots();

  Stream<QuerySnapshot> lastExpense(String userID) => _firestore
    .collection('userFinance')
    .document(userID)
    .collection('expenses')
    .orderBy('timestamp', descending: true)
    .limit(1)
    .snapshots();
}
