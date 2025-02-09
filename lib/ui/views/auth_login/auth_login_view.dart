import 'package:dayfi/app/app.router.dart';
import 'package:dayfi/ui/common/app_scaffold.dart';
import 'package:dayfi/ui/common/buttons/filled_btn.dart';
import 'package:dayfi/ui/common/textfields/textfield_cus.dart';
import 'package:dayfi/ui/common/ui_helpers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'auth_login_viewmodel.dart';

class AuthLoginView extends StackedView<AuthLoginViewModel> {
  // ignore: use_super_parameters
  const AuthLoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthLoginViewModel viewModel,
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
                "Sign in to your account",
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
                "Enter your login information to sign in and enjoy seamless transactions.",
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
                label: "Email Address",
                hintText: "dayfi@example.com",
              ),
              verticalSpace(17.5),
              CustomTextField(
                label: "Password",
                hintText: "****************",
              ),
              verticalSpace(17.5),
              Align(
                alignment: Alignment.centerRight,
                child: Text.rich(
                  textAlign: TextAlign.end,
                  TextSpan(
                    text: "I forgot my password!",
                    style: TextStyle(
                      // fontFamily: 'Karla',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0,
                      height: 1.4,
                      color: Color(0xffff0082),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        viewModel.navigationService
                            .navigateToAuthForgotPasswordView();
                      },
                  ),
                ),
              ),
              verticalSpace(72),
              SizedBox(
                child: FilledBtn(
                  onPressed: () {
                    viewModel.navigationService.navigateToMainView();
                  },
                  text: "Login",
                  textColor: Colors.white,
                  backgroundColor: Color(0xffff0082),
                ),
              ),
              SizedBox(height: 24.h),
              Center(
                child: Text.rich(
                  textAlign: TextAlign.end,
                  TextSpan(
                    text: "I don't have an account",
                    style: TextStyle(
                      // fontFamily: 'Karla',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                      height: 1.4,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          // ignore: deprecated_member_use
                          .withOpacity(.85),
                    ),
                    children: [
                      TextSpan(
                        text: " Signup",
                        style: TextStyle(
                          // fontFamily: 'Karla',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0,
                          height: 1.4,
                          color: Color(0xffff0082),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            viewModel.navigationService
                                .navigateToAuthSignupView();
                          },
                      )
                    ],
                  ),
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
  AuthLoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AuthLoginViewModel();
}
