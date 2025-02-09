import 'package:dayfi/ui/common/app_scaffold.dart';
import 'package:dayfi/ui/common/buttons/filled_btn.dart';
import 'package:dayfi/ui/common/textfields/textfield_cus.dart';
import 'package:dayfi/ui/common/transaction.dart';
import 'package:dayfi/ui/common/ui_helpers.dart';
import 'package:dayfi/ui/views/scan_to_pay.dart';
import 'package:dayfi/ui/views/tap_to_pay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'payment_setup_viewmodel.dart';

class PaymentSetupView extends StackedView<PaymentSetupViewModel> {
  final String selectedPaymentMethod;
  final TransactionService transactionService;
  const PaymentSetupView({
    Key? key,
    required this.selectedPaymentMethod,
    required this.transactionService,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PaymentSetupViewModel viewModel,
    Widget? child,
  ) {
    return AppScaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: Color(0xfff7f7f7),
        elevation: 0,
      ),
      body: StatefulBuilder(builder: (BuildContext context, setState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(8),
                    Text(
                      "Payment setup",
                      style: TextStyle(
                        fontSize: 32,
                        height: 1.2,
                        color: Color.fromARGB(255, 49, 17, 34),
                        // color: Color.fromARGB(255, 49, 17, 34),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpace(12),
                    Text(
                      "Set your payment by selecting the currency you want to receive and the amount",
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
                  ],
                ),
                verticalSpace(40),
                CustomTextField(
                  shouldReadOnly: true,
                  controller: viewModel.currencyTextController,
                  label: "Select Currency",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      "assets/svgs/nigeria.png",
                      height: 12,
                    ),
                  ),
                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                  onTap: () {
                    setState(() => viewModel.showCurrencyOptions =
                        !viewModel.showCurrencyOptions);
                  },
                  enableInteractiveSelection: false,
                ),
                const SizedBox(height: 8),
                viewModel.showCurrencyOptions
                    ? AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: AnimatedContainer(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Color(0xffff0082).withOpacity(0.25),
                            ),
                          ),
                          duration: Duration(milliseconds: 250),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: viewModel.currencies.map(
                              (currency) {
                                final isNgn = currency.name == "NGN";
                                return InkWell(
                                  onTap: () {
                                    isNgn
                                        ? setState(() => viewModel
                                            .showCurrencyOptions = false)
                                        : null;
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: isNgn
                                        ? Color.fromARGB(255, 49, 17, 34)
                                            .withOpacity(0.1)
                                        : Colors.transparent,
                                    padding: EdgeInsets.symmetric(
                                      vertical: isNgn ? 12 : 12,
                                      horizontal: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              currency.icon,
                                              height: 26,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              currency.name,
                                              style: TextStyle(
                                                // fontFamily: 'Karla',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0,
                                                height: 1.4,
                                              ),
                                            ),
                                          ],
                                        ),
                                        isNgn
                                            ? SvgPicture.asset(
                                                "assets/svgs/circle-check.svg",
                                                color: Color(0xffff0082),
                                              )
                                            : Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 6, vertical: 6),
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                          255, 49, 17, 34)
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  "Coming soon.",
                                                  style: TextStyle(
                                                    // fontFamily: 'Karla',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: -0.4,
                                                    height: 1.4,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                verticalSpace(17.5),
                CustomTextField(
                  controller: viewModel.amountController,
                  label: "Enter Amount",
                  keyboardType: TextInputType.number,
                  prefix: Text(
                    "NGN  ",
                    style: TextStyle(
                      // fontFamily: 'Karla',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .1,
                      height: 1.4,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          // ignore: deprecated_member_use
                          .withOpacity(.75),
                    ),
                  ),
                ),
                // verticalSpace(17.5),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 24.h),
                      FilledBtn(
                        onPressed: () {
                          selectedPaymentMethod == "Scan to Pay"
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScanToPay(
                                      amount: double.parse(
                                          viewModel.amountController.text),
                                      transactionService: transactionService,
                                    ),
                                  ))
                              : selectedPaymentMethod == "Tap to Pay (NFC)"
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TapToPay(
                                          amount: double.parse(
                                              viewModel.amountController.text),
                                          transactionService:
                                              transactionService,
                                        ),
                                      ))
                                  : null;
                        },
                        backgroundColor: Color(0xffff0082),
                        text: "Proceed",
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
                verticalSpace(40),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  PaymentSetupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PaymentSetupViewModel();
}
