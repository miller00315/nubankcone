import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExpenseModel {
  final String id;
  final double expenseValue;
  final Timestamp timestamp;

  ExpenseModel({
    @required this.id, 
    @required this.expenseValue, 
    @required this.timestamp});

  factory ExpenseModel.fromDocument({DocumentSnapshot document}) {
    return ExpenseModel(
      id: document['id'],
      expenseValue: document['expnseValue'],
      timestamp: document['timestamp'],
    );
  }
}