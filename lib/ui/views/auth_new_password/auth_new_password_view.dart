import 'package:dayfi/ui/common/app_scaffold.dart';
import 'package:dayfi/ui/common/buttons/filled_btn.dart';
import 'package:dayfi/ui/common/textfields/textfield_cus.dart';
import 'package:dayfi/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'auth_new_password_viewmodel.dart';

class AuthNewPasswordView extends StackedView<AuthNewPasswordViewModel> {
  const AuthNewPasswordView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthNewPasswordViewModel viewModel,
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
                "Set new password",
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
                "Create a new password for your dayfi account and get back in!",
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
              verticalSpace(54),
              CustomTextField(
                controller: viewModel.passwordController,
                label: "Password",
                hintText: "****************",
              ),
              verticalSpace(17.5),
              CustomTextField(
                controller: viewModel.verifyPasswordController,
                label: "Verify Password",
                hintText: "****************",
              ),
              verticalSpace(72),
              SizedBox(
                child: FilledBtn(
                  onPressed: () {
                    // viewModel.navigationService.navigateToAuthVerifyCodeView();
                  },
                  text: "Next - Login",
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
  AuthNewPasswordViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AuthNewPasswordViewModel();
}
