import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Transaction {
  final String id;
  final String type; // 'FUND', 'BUY', 'SELL'
  final double amount;
  final String fromCurrency;
  final String toCurrency;
  final DateTime timestamp;
  final double balance; // Balance after transaction

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.fromCurrency,
    required this.toCurrency,
    required this.balance,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'amount': amount,
        'fromCurrency': fromCurrency,
        'toCurrency': toCurrency,
        'balance': balance,
        'timestamp': timestamp.toIso8601String(),
      };

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['id'],
        type: json['type'],
        amount: json['amount'],
        fromCurrency: json['fromCurrency'],
        toCurrency: json['toCurrency'],
        balance: json['balance'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}

// services/transaction_service.dart

class TransactionService {
  static const String _transactionsKey = 'transactions';
  static const String _balanceKey = 'ngn_balance';
  final SharedPreferences _prefs;

  TransactionService(this._prefs);

  // Get current NGN balance
  double getNairaBalance() {
    return _prefs.getDouble(_balanceKey) ?? 0.0;
  }

  // Update NGN balance
  Future<void> updateNairaBalance(double newBalance) async {
    await _prefs.setDouble(_balanceKey, newBalance);
  }

  // Get all transactions
  List<Transaction> getTransactions() {
    final String? data = _prefs.getString(_transactionsKey);
    if (data == null) return [];

    final List<dynamic> jsonData = jsonDecode(data);
    return jsonData.map((json) => Transaction.fromJson(json)).toList();
  }

  // Add new transaction
  Future<void> addTransaction({
    required String type,
    required double amount,
    required String fromCurrency,
    required String toCurrency,
  }) async {
    final transactions = getTransactions();
    double currentBalance = getNairaBalance();

    // Update Naira balance based on transaction type
    if (type == 'FUND') {
      currentBalance += amount;
    } else if (type == 'BUY') {
      currentBalance -= amount;
    } else if (type == 'SELL') {
      currentBalance += amount;
    }

    // Create new transaction
    final transaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      amount: amount,
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
      balance: currentBalance,
    );

    // Add to list and save
    transactions.add(transaction);
    await _prefs.setString(_transactionsKey,
        jsonEncode(transactions.map((t) => t.toJson()).toList()));

    // Update balance
    await updateNairaBalance(currentBalance);
  }

  // Get transactions for a specific currency
  List<Transaction> getTransactionsForCurrency(String currency) {
    return getTransactions()
        .where((t) => t.fromCurrency == currency || t.toCurrency == currency)
        .toList();
  }

  // Clear all transactions (useful for testing)
  Future<void> clearTransactions() async {
    await _prefs.remove(_transactionsKey);
    await _prefs.remove(_balanceKey);
  }
}
