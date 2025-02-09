import 'package:dayfi/app/app.locator.dart';
import 'package:dayfi/ui/common/transaction.dart';
import 'package:dayfi/ui/views/tab_home/tab_home_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TabHistoryViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  TransactionService? transactionService;
  SharedPreferences? prefs;

  // Transaction and balance related properties
  List<Transaction> transactions = [];
  double nairaBalance = 0.0;

  // Initialize services
  Future<void> init() async {
    setBusy(true);
    prefs = await SharedPreferences.getInstance();
    transactionService = TransactionService(prefs!);
    await loadTransactionsAndBalance();
    setBusy(false);
  }

  // Load transactions and balance
  Future<void> loadTransactionsAndBalance() async {
    transactions = transactionService!.getTransactions();
    nairaBalance = transactionService!.getNairaBalance();
    notifyListeners();
  }

  // Add new transaction
  Future<void> addTransaction({
    required String type,
    required double amount,
    required String fromCurrency,
    required String toCurrency,
  }) async {
    await transactionService!.addTransaction(
      type: type,
      amount: amount,
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
    );
    await loadTransactionsAndBalance();
  }

  // Get recent transactions (last 5)
  List<Transaction> get recentTransactions {
    return transactions.take(5).toList();
  }

  // Get formatted balance
  String get formattedBalance {
    return nairaBalance.toStringAsFixed(2);
  }

  // Helper methods for transactions
  bool get hasTransactions => transactions.isNotEmpty;

  // Get transactions for a specific currency
  List<Transaction> getTransactionsForCurrency(String currency) {
    return transactionService!.getTransactionsForCurrency(currency);
  }

  // Fund wallet
  Future<void> fundWallet(double amount) async {
    await addTransaction(
      type: 'FUND',
      amount: amount,
      fromCurrency: 'BANK',
      toCurrency: 'NGN',
    );
  }

  // Buy crypto
  Future<void> buyCrypto(String cryptoCurrency, double ngnAmount) async {
    await addTransaction(
      type: 'BUY',
      amount: ngnAmount,
      fromCurrency: 'NGN',
      toCurrency: cryptoCurrency,
    );
  }

  // Sell crypto
  Future<void> sellCrypto(
      String cryptoCurrency, double cryptoAmount, double ngnAmount) async {
    await addTransaction(
      type: 'SELL',
      amount: ngnAmount,
      fromCurrency: cryptoCurrency,
      toCurrency: 'NGN',
    );
  }

  String selectedPaymentMethod = "";

  final List<String> beforeReceivingFunds = [
    "Receive NGN funds instantly.",
    "Securely stored in your NGN wallet.",
    "Use funds to buy digital assets.",
    "Tap below to start now!",
  ];

  final List<String> kycLevel1Verification = [
    "Phone Number (to provide secure login and notifications)",
    "Address (to verify your location)",
    "Country of Residence (to meet regulatory requirements)",
    "Date of Birth (to confirm you are of legal age)",
  ];

  final List<PaymentMethodModel> paymentMethods = [
    PaymentMethodModel(
      icon: "assets/svgs/tap_.svg",
      name: "Tap to Pay (NFC)",
    ),
    PaymentMethodModel(
      icon: "assets/svgs/scan_.svg",
      name: "Scan to Pay",
    ),
  ];
}
