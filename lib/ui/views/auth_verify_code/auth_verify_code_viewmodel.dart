import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class AuthVerifyCodeViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final TextEditingController otpCodeTextEditingController =
      TextEditingController();
}
