import 'package:flutter/material.dart';

void showDebitCardValidSnackbar(BuildContext context) {
  final snackBar = SnackBar(
    elevation: 0,
    content: const Text(
      '✅ Debit Card Valid',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    duration: const Duration(seconds: 2),
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - 100,
      left: 20,
      right: 20,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}