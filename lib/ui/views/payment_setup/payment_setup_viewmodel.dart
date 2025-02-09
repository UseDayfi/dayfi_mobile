import 'package:dayfi/app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PaymentSetupViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  final currencyTextController = TextEditingController(
    text: "NGN",
  );

  final amountController = TextEditingController();

  bool showCurrencyOptions = false;

  final List<CurrencyModel> currencies = [
    CurrencyModel(
      name: "NGN",
      icon: "assets/svgs/nigeria.png",
    ),
    CurrencyModel(
      name: 'USD',
      icon: "assets/svgs/united-states.png",
    ),
    CurrencyModel(
      name: "GBP",
      icon: "assets/svgs/united-kingdom.png",
    ),
    CurrencyModel(
      name: "EUR",
      icon: "assets/svgs/european-union.png",
    ),
  ];

  // void scanCard() async {
  //   cardInfo = null;
  //   notifyListeners();
  //   final result =
  //       await navigationService.navigateToScanToPayView() as CardInfo?;
  //   if (result != null) {
  //     cardInfo = result;
  //     notifyListeners();
  //   }
  // }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}

class CurrencyModel {
  final String name;
  final String icon;

  CurrencyModel({
    required this.icon,
    required this.name,
  });
}
