import 'package:dayfi/app/app.router.dart';
import 'package:dayfi/ui/common/app_scaffold.dart';
import 'package:dayfi/ui/common/buttons/filled_btn.dart';
import 'package:dayfi/ui/common/textfields/textfield_cus.dart';
import 'package:dayfi/ui/common/ui_helpers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'auth_signup_viewmodel.dart';

class AuthSignupView extends StackedView<AuthSignupViewModel> {
  // ignore: use_super_parameters
  const AuthSignupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthSignupViewModel viewModel,
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
                "Welcome to dayfi!",
                style: TextStyle(
                  fontSize: 32,
                  height: 1.2,
                  color: Color.fromARGB(255, 49, 17, 34),
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(12),
              Text(
                "Let's begin by requesting your fundamental details to get started.",
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
              verticalSpace(48),
              CustomTextField(
                controller: viewModel.emailAddessController,
                label: "Email Address",
                hintText: "dayfi@example.com",
              ),
              verticalSpace(17.5),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: viewModel.firstNameController,
                      label: "First Name",
                      hintText: "Sade",
                    ),
                  ),
                  horizontalSpaceSmall,
                  Expanded(
                    child: CustomTextField(
                      controller: viewModel.lastNameController,
                      label: "Last Name (Surname)",
                      hintText: "Olukoya",
                    ),
                  ),
                ],
              ),
              verticalSpace(17.5),
              CustomTextField(
                controller: viewModel.middleNameController,
                label: "Middle Name (Optional)",
                hintText: "Ejiro",
              ),
              verticalSpace(17.5),
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
              verticalSpace(28),
              // Text.rich(
              //   textAlign: TextAlign.end,
              //   TextSpan(
              //     text:
              //         "By continuing, you agree to the Terms of Use and Privacy Policy.",
              //     style: TextStyle(
              //       // fontFamily: 'Karla',
              //       fontSize: 14,
              //       fontWeight: FontWeight.w500,
              //       letterSpacing: 0,
              //       height: 1.4,
              //       color: Theme.of(context)
              //           .textTheme
              //           .bodyLarge!
              //           .color!
              //           // ignore: deprecated_member_use
              //           .withOpacity(.85),
              //     ),
              //   ),
              // ),
              verticalSpace(12),
              SizedBox(
                child: FilledBtn(
                  onPressed: () {
                    viewModel.verifyOTP();
                  },
                  text: "Next - Email verification",
                  textColor: Colors.white,
                  backgroundColor: Color(0xffff0082),
                ),
              ),
              SizedBox(height: 24.h),
              Center(
                child: Text.rich(
                  textAlign: TextAlign.end,
                  TextSpan(
                    text: "I have an account",
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
                        text: " Log in",
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
                                .navigateToAuthLoginView();
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
  AuthSignupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AuthSignupViewModel();
}
