import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

enum SnackBarType { red, kcSuccessColor }

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  service.registerCustomSnackbarConfig(
    variant: SnackBarType.red,
    config: SnackbarConfig(
      backgroundColor: Colors.red,
      textColor: Colors.white,
      margin: const EdgeInsets.all(20),
      duration: const Duration(seconds: 3),
      borderRadius: 8,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      snackPosition: SnackPosition.TOP,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackBarType.kcSuccessColor,
    config: SnackbarConfig(
      margin: const EdgeInsets.all(20),
      duration: const Duration(seconds: 3),
      textColor: Colors.white,
      borderRadius: 8,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      snackPosition: SnackPosition.TOP,
    ),
  );
}
