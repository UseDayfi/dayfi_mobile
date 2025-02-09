import 'package:dayfi/app/app.router.dart';
import 'package:dayfi/ui/common/app_scaffold.dart';
import 'package:dayfi/ui/common/buttons/filled_btn.dart';
import 'package:dayfi/ui/common/textfields/pin_code_widget.dart';
import 'package:dayfi/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'auth_verify_code_viewmodel.dart';

class AuthVerifyCodeView extends StackedView<AuthVerifyCodeViewModel> {
  // ignore: use_super_parameters
  const AuthVerifyCodeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthVerifyCodeViewModel viewModel,
    Widget? child,
  ) {
    return AppScaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: Color(0xfff7f7f7),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(8),
              Text(
                "Reset OTP",
                style: TextStyle(
                  fontSize: 32,
                  height: 1.2,
                  color: Color.fromARGB(255, 49, 17, 34),
                  // color: Color(0xffff0082),
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(12),
              Text(
                "We've sent you reset codes to your email. Please, check your inbox, copy the codes from the email, and paste them here.",
                style: TextStyle(
                  // fontFamily: 'Karla',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: .1,
                  height: 1.4,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      // ignore: deprecated_member_use
                      .withOpacity(.85),
                ),
                textAlign: TextAlign.start,
              ),
              verticalSpace(40),
              PinTextField(
                length: 6,
                controller: viewModel.otpCodeTextEditingController,
                onTextChanged: (value) {
                  if (value.length != 6) {
                    // viewModel.buttonColor = kcLightGrey.withOpacity(.4);
                    // viewModel.buttonTextColor =
                    //     kcDarkGreyColor.withOpacity(.7);
                    // viewModel.notifyListeners();
                  } else {
                    // viewModel.buttonColor = Color(0xffff0082);
                    // viewModel.buttonTextColor = Colors.white;
                    // viewModel.notifyListeners();
                  }
                },
              ),
              verticalSpace(88),
              SizedBox(
                child: FilledBtn(
                  onPressed: () {
                    viewModel.navigationService.navigateToAuthNewPasswordView();
                  },
                  text: "Next - Reset New Password",
                  textColor: Colors.white,
                  backgroundColor: Color(0xffff0082),
                ),
              ),
              verticalSpace(40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AuthVerifyCodeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AuthVerifyCodeViewModel();
}
