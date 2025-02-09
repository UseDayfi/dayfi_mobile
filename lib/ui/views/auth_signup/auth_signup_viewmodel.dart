import 'package:dayfi/app/app.locator.dart';
import 'package:dayfi/services/auth_services.dart';
import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthSignupViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  // final _storage = GetStorage();

  final AuthServices _authServices = AuthServices();

  final TextEditingController emailAddessController = TextEditingController(),
      firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      middleNameController = TextEditingController(),
      passwordController = TextEditingController(),
      verifyPasswordController = TextEditingController();

  // Map<String, dynamic> _resolveData() {
  //   return <String, dynamic>{}..addAll(_resolveMetadataFieldsData());
  // }

  // Map<String, dynamic> _resolveMetadataFieldsData() {
  //   return <String, dynamic>{};
  // }

  signUpUser() {
    _authServices.signUp(
        emailAddessController.text.trim(), passwordController.text.trim());
  }

  verifyOTP() {
    _authServices.verifyOTP(emailAddessController.text.trim(), "161337");
  }

  @override
  void dispose() {
    emailAddessController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    middleNameController.dispose();
    passwordController.dispose();
    verifyPasswordController.dispose();
    super.dispose();
  }
}
