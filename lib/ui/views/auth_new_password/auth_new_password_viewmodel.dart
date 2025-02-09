import 'package:dayfi/app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthNewPasswordViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  final TextEditingController passwordController = TextEditingController(),
      verifyPasswordController = TextEditingController();
}
