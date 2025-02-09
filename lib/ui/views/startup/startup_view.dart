import 'package:dayfi/app/app.router.dart';
import 'package:dayfi/ui/common/app_scaffold.dart';
import 'package:dayfi/ui/common/buttons/filled_btn.dart';
import 'package:dayfi/ui/common/buttons/outline_btn.dart';
import 'package:dayfi/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  // ignore: use_super_parameters
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return AppScaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: Color(0xfff7f7f7),
              // child: Center(
              //   child: SvgPicture.asset(
              //     'assets/svgs/app_logo.svg',
              //     width: MediaQuery.of(context).size.width * .4,
              //   ),
              // ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 18,
              ),
              constraints: BoxConstraints.expand(),
              child: Column(
                children: [
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  Text(
                    "Financial Inclusion\nfor All.",
                    // "No Other External Hardware, Just Your Mobile Phone",
                    // "Your mobile phone,\nyour POS device.",
                    style: TextStyle(
                      fontSize: 38,
                      height: 1.2,
                      letterSpacing: .4,
                      color: Color.fromARGB(255, 49, 17, 34),
                      // color: Color(0xffff0082),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(14),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .08,
                    ),
                    child: Text(
                      "Empowering Africa through Cryptocurrency Access.",
                      // "Receiving money shouldn't be a source of worry anymore, the solution is here!",
                      // "The powerful payment platform that is designed to meet the needs of businesses of all sizes, enabling you to collect payments however you choose.",
                      // "Effortless payments for every business—collect money your way.",
                      style: TextStyle(
                          // fontFamily: 'Karla',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: .2,
                          height: 1.4,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(.85)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  SizedBox(
                    child: FilledBtn(
                      onPressed: () {
                        viewModel.navigationService.navigateToAuthSignupView();
                      },
                      text: "Sign Up",
                      textColor: Colors.white,
                      backgroundColor: Color(0xffff0082),
                    ),
                  ),
                  verticalSpace(14),
                  SizedBox(
                    child: OutlineBtn(
                      onPressed: () {
                        viewModel.navigationService.navigateToAuthLoginView();
                      },
                      text: "Login",
                      textColor: Color.fromARGB(255, 49, 17, 34),
                      borderColor: Color.fromARGB(255, 49, 17, 34),
                    ),
                  ),
                  Spacer(),
                  Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();
}
