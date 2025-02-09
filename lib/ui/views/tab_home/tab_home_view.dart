import 'dart:developer';
import 'dart:ui';

// import 'package:dayfi/app/app.router.dart';
import 'package:dayfi/ui/common/app_scaffold.dart';
import 'package:dayfi/ui/common/buttons/filled_btn.dart';
import 'package:dayfi/ui/common/stay_tuned_dialog.dart';
import 'package:dayfi/ui/common/transaction.dart';
// import 'package:dayfi/ui/common/buttons/outline_btn.dart';
import 'package:dayfi/ui/common/ui_helpers.dart';
import 'package:dayfi/ui/views/payment_setup/payment_setup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'tab_home_viewmodel.dart';

class BalanceDisplay extends StatelessWidget {
  final double balance;
  final bool isLoading;

  const BalanceDisplay({
    Key? key,
    required this.balance,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(
            minHeight: 50, // Provide minimum height to prevent layout jumps
            maxHeight: 50,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: 0.0,
                  child: child,
                ),
              );
            },
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Text(
                    balance.toStringAsFixed(2),
                    key: ValueKey<double>(balance), // Unique key for animation
                    style: const TextStyle(
                      fontSize: 36,
                      height: 1.2,
                      color: Color(0xFF311122),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class TabHomeView extends StackedView<TabHomeViewModel> {
  // ignore: use_super_parameters
  const TabHomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TabHomeViewModel viewModel,
    Widget? child,
  ) {
    log(viewModel.nairaBalance.toStringAsFixed(2));
    return AppScaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: Color(0xfff7f7f7),
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Color.fromARGB(255, 49, 17, 34).withOpacity(.2),
              backgroundImage: const NetworkImage(
                'https://avatar.iran.liara.run/public/52',
              ),
            ),
            horizontalSpaceSmall,
            Text(
              "Hi, Ife",
              style: TextStyle(
                // fontFamily: 'Karla',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: .1,
                height: 1.4,
                color: Color.fromARGB(255, 49, 17, 34),
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(8),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 49, 17, 34).withOpacity(.2),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/svgs/nigeria.png",
                                height: 26,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "NGN",
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
                          const SizedBox(height: 18),
                          Text(
                            "Your combined total",
                            style: TextStyle(
                              // fontFamily: 'Karla',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  // ignore: deprecated_member_use
                                  .withOpacity(.55),
                            ),
                          ),
                          BalanceDisplay(
                            balance: viewModel.nairaBalance,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 18.0.w),
                padding: const EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.amber.withOpacity(.4),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text:
                              "Be part of the 4% that own digital assets, all in a few steps, with the best rates",
                          style: TextStyle(
                            fontFamily: 'DegularDisplay',
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(.8),
                            fontSize: 14,
                            letterSpacing: .45,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              _buildFYI(context, viewModel),
              const SizedBox(height: 12),
              Text(
                "My Wallets",
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: .4,
                  color: Color.fromARGB(255, 49, 17, 34),
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 12),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width * .4,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Nigerian Naira",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("NGN 0", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: .4,
                  color: Color.fromARGB(255, 49, 17, 34),
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 12),
              if (viewModel.hasTransactions) ...[
                Container(
                  // height: 500,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: viewModel.recentTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = viewModel.recentTransactions[index];
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _getTransactionColor(transaction.type)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              _getTransactionIcon(transaction.type),
                              color: _getTransactionColor(transaction.type),
                              size: 20,
                            ),
                          ),
                          title: Text(
                            _getTransactionTitle(transaction),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 49, 17, 34),
                            ),
                          ),
                          subtitle: Text(
                            _formatDate(transaction.timestamp),
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 49, 17, 34)
                                  .withOpacity(0.6),
                            ),
                          ),
                          trailing: Text(
                            _formatAmount(transaction),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _getAmountColor(transaction.type),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ] else ...[
                // Empty state
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Icon(
                        Icons.history,
                        size: 48,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "No transactions yet",
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              Color.fromARGB(255, 49, 17, 34).withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getTransactionIcon(String type) {
    switch (type) {
      case 'FUND':
        return Icons.add_circle_outline;
      case 'BUY':
        return Icons.shopping_cart_outlined;
      case 'SELL':
        return Icons.sell_outlined;
      default:
        return Icons.swap_horiz_outlined;
    }
  }

  Color _getTransactionColor(String type) {
    switch (type) {
      case 'FUND':
        return Colors.green;
      case 'BUY':
        return Colors.blue;
      case 'SELL':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  Color _getAmountColor(String type) {
    switch (type) {
      case 'FUND':
      case 'SELL':
        return Colors.green;
      case 'BUY':
        return Colors.red;
      default:
        return Color.fromARGB(255, 49, 17, 34);
    }
  }

  String _getTransactionTitle(Transaction transaction) {
    switch (transaction.type) {
      case 'FUND':
        return 'Funded Wallet';
      case 'BUY':
        return 'Bought ${transaction.toCurrency}';
      case 'SELL':
        return 'Sold ${transaction.fromCurrency}';
      default:
        return 'Transaction';
    }
  }

  String _formatAmount(Transaction transaction) {
    final prefix = transaction.type == 'BUY' ? '-' : '+';
    return '$prefix NGN ${transaction.amount.toStringAsFixed(2)}';
  }

  Widget _buildFYI(
    BuildContext context,
    TabHomeViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => showStayTunedDialog(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 22,
                    child: Transform.rotate(
                        angle: 3.12,
                        child: CircleAvatar(
                            child: SvgPicture.asset('assets/svgs/send-2.svg'))),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Buy",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // color: colorPrimary100,
                      letterSpacing: -.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24,
            width: 1,
            // color: colorPrimary100,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => showStayTunedDialog(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 22,
                      child: SvgPicture.asset("assets/svgs/send-2.svg")),
                  const SizedBox(height: 4),
                  Text(
                    "Sell",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // color: colorPrimary100,
                      letterSpacing: -.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24,
            width: 1,
            // color: colorPrimary100,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  _showReceiveFundsNoticeBottomSheet(context, viewModel),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                      angle: 3.12,
                      child: CircleAvatar(
                          radius: 22,
                          child: SvgPicture.asset('assets/svgs/send-2.svg'))),
                  const SizedBox(height: 4),
                  Text(
                    "Deposit",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // color: colorPrimary100,
                      letterSpacing: -.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24,
            width: 1,
            // color: colorPrimary100,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 22,
                    child: SvgPicture.asset('assets/svgs/send-2.svg')),
                const SizedBox(height: 4),
                Text(
                  "Withdraw",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: colorPrimary100,
                    letterSpacing: -.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showReceiveFundsNoticeBottomSheet(
    BuildContext context,
    TabHomeViewModel viewModel,
  ) {
    showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 49, 17, 34).withOpacity(.2),
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Color(0xfff7f7f7),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 48,
                      height: 3.5,
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(.1)),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => viewModel.navigationService.back(),
                      child: SvgPicture.asset(
                        'assets/svgs/cancel.svg',
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 27,
                          backgroundColor: Colors.white,
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/svgs/credit-card-refund.svg",
                              height: 28,
                              color: Color(0xffff0082),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .011),
                      Text(
                        "Before receiving funds",
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w900,
                            height: 1.2,
                            letterSpacing: .4,
                            color: Color.fromARGB(255, 49, 17, 34)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Here are a few things you need to note before receiving funds on dayfi",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // fontFamily: 'Karla',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .1,
                            height: 1.4,
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(.75),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal: 18.0.w),
                    padding: const EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Color(0xffff0082).withOpacity(.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int index = 0;
                            index < viewModel.beforeReceivingFunds.length;
                            index++)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 4,
                              bottom: 4,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                      // fontFamily: 'Karla',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0,
                                      height: 1.4,
                                      color: Color(0xffff0082)),
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    viewModel.beforeReceivingFunds[index],
                                    style: TextStyle(
                                      // fontFamily: 'Karla',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0,
                                      height: 1.4,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 8.h),
                        FilledBtn(
                          onPressed: () {
                            viewModel.navigationService.back();
                            // viewModel.navigationService
                            //     .navigateToPaymentSetupView();

                            _showSelectPaymentMethodBottomSheet(
                                context, viewModel);
                          },
                          backgroundColor: Color(0xffff0082),
                          text: "Agree and continue",
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void _showSelectPaymentMethodBottomSheet(
    BuildContext context,
    TabHomeViewModel viewModel,
  ) {
    showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 49, 17, 34).withOpacity(.2),
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Color(0xfff7f7f7),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 48,
                      height: 3.5,
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(.1)),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => viewModel.navigationService.back(),
                      child: SvgPicture.asset(
                        'assets/svgs/cancel.svg',
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SvgPicture.asset(
                      //   "",
                      //   height: 54,
                      // ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .011),
                      Text(
                        "Select Payment Method",
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w900,
                            height: 1.2,
                            letterSpacing: .4,
                            color: Color.fromARGB(255, 49, 17, 34)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Select a payment method to receive your funds on dayfi",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // fontFamily: 'Karla',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .1,
                            height: 1.4,
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(.75),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     "Select Payment Method",
                  //     style: TextStyle(
                  //       // fontFamily: 'Karla',
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.bold,
                  //       letterSpacing: .1,
                  //       height: 1.4,
                  //       color: Color(0xffff0082),
                  //     ),
                  //     textAlign: TextAlign.start,
                  //   ),
                  // ),
                  // verticalSpace(8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: AnimatedContainer(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Color(0xffff0082).withOpacity(0.25),
                        ),
                      ),
                      duration: Duration(milliseconds: 250),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: viewModel.paymentMethods.map((paymentMethod) {
                          return InkWell(
                            onTap: () {
                              setState(() => viewModel.selectedPaymentMethod =
                                  paymentMethod.name);
                            },
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              color: viewModel.selectedPaymentMethod ==
                                      paymentMethod.name
                                  ? Color.fromARGB(255, 49, 17, 34)
                                      .withOpacity(0.1)
                                  : Colors.transparent,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        paymentMethod.icon,
                                        height: 30,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        paymentMethod.name,
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
                                  viewModel.selectedPaymentMethod ==
                                          paymentMethod.name
                                      ? SvgPicture.asset(
                                          "assets/svgs/circle-check.svg",
                                          color: Color(0xffff0082),
                                        )
                                      : const SizedBox.shrink()
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Image.asset(
                          'assets/svgs/paystack-badge-cards-.png',
                          width: MediaQuery.of(context).size.width * .4,
                        ),
                        SizedBox(height: 16.h),
                        FilledBtn(
                          onPressed: () {
                            // viewModel.navigationService.back();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PaymentSetupView(
                                  selectedPaymentMethod:
                                      viewModel.selectedPaymentMethod,
                                  transactionService:
                                      viewModel.transactionService!,
                                ),
                              ),
                            );

                            //  await   viewModel.navigationService
                            //         .navigateToPaymentSetupView();
                          },
                          backgroundColor: Color(0xffff0082),
                          text: "Next - Payment setup",
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  // void _showKYCNoticeBottomSheet(
  //   BuildContext context,
  //   TabHomeViewModel viewModel,
  // ) {
  //   showModalBottomSheet(
  //     backgroundColor: Color.fromARGB(255, 49, 17, 34).withOpacity(.2),
  //     context: context,
  //     isDismissible: false,
  //     isScrollControlled: true,
  //     elevation: 0,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (context) {
  //       return BackdropFilter(
  //         filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
  //         child: Container(
  //           padding:
  //               const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
  //           decoration: BoxDecoration(
  //             color: Color(0xfff7f7f7),
  //             borderRadius: const BorderRadius.only(
  //               topLeft: Radius.circular(24),
  //               topRight: Radius.circular(24),
  //             ),
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Align(
  //                 alignment: Alignment.topCenter,
  //                 child: Container(
  //                   width: 48,
  //                   height: 3.5,
  //                   margin: const EdgeInsets.only(top: 8),
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(6),
  //                       color: Theme.of(context)
  //                           .textTheme
  //                           .bodyLarge!
  //                           .color!
  //                           .withOpacity(.1)),
  //                 ),
  //               ),
  //               SizedBox(height: MediaQuery.of(context).size.height * .01),
  //               Align(
  //                 alignment: Alignment.centerRight,
  //                 child: InkWell(
  //                   onTap: () => viewModel.navigationService.back(),
  //                   child: SvgPicture.asset(
  //                     'assets/svgs/cancel.svg',
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: MediaQuery.of(context).size.height * .01),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   SizedBox(height: MediaQuery.of(context).size.height * .011),
  //                   Text(
  //                     "Dayfi needs your permission",
  //                     style: TextStyle(
  //                         fontSize: 22.sp,
  //                         fontWeight: FontWeight.w900,
  //                         height: 1.2,
  //                         letterSpacing: .4,
  //                         color: Color.fromARGB(255, 49, 17, 34)),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                   SizedBox(height: 5.h),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //                     child: Text(
  //                       "Please read our KYC data collection statement and provide your consent to continue",
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                         // fontFamily: 'Karla',
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.bold,
  //                         letterSpacing: .1,
  //                         height: 1.4,
  //                         color: Theme.of(context)
  //                             .textTheme
  //                             .bodyLarge!
  //                             .color!
  //                             .withOpacity(.75),
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 8),
  //                   Text.rich(
  //                     textAlign: TextAlign.start,
  //                     TextSpan(
  //                       text:
  //                           "To complete your KYC Level 1 verification, Dayfi will collect the following instructions:",
  //                       style: TextStyle(
  //                         // fontFamily: 'Karla',
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w500,
  //                         letterSpacing: .2,
  //                         height: 1.3,
  //                         color: Theme.of(context)
  //                             .textTheme
  //                             .bodyLarge!
  //                             .color!
  //                             // ignore: deprecated_member_use
  //                             .withOpacity(.85),
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 8),
  //                   Container(
  //                     // margin: EdgeInsets.symmetric(horizontal: 18.0.w),
  //                     padding: const EdgeInsets.all(12),
  //                     width: MediaQuery.of(context).size.width,
  //                     decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(6),
  //                       border: Border.all(
  //                         color: Color(0xffff0082).withOpacity(.2),
  //                       ),
  //                     ),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         for (int index = 0;
  //                             index < viewModel.kycLevel1Verification.length;
  //                             index++)
  //                           Padding(
  //                             padding: const EdgeInsets.only(
  //                               top: 4,
  //                               bottom: 4,
  //                             ),
  //                             child: Row(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Text(
  //                                   "${index + 1}",
  //                                   style: TextStyle(
  //                                       // fontFamily: 'Karla',
  //                                       fontSize: 15,
  //                                       fontWeight: FontWeight.w500,
  //                                       letterSpacing: 0,
  //                                       height: 1.4,
  //                                       color: Color(0xffff0082)),
  //                                   textAlign: TextAlign.start,
  //                                 ),
  //                                 const SizedBox(width: 8),
  //                                 Expanded(
  //                                   child: Text(
  //                                     viewModel.kycLevel1Verification[index],
  //                                     style: TextStyle(
  //                                       // fontFamily: 'Karla',
  //                                       fontSize: 14,
  //                                       fontWeight: FontWeight.w500,
  //                                       letterSpacing: 0,
  //                                       height: 1.4,
  //                                     ),
  //                                     textAlign: TextAlign.start,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 8),
  //               Text(
  //                 "By continuing, you acknowledge that you have read and understood the KYC data collection statement and agree to the terms to proceed with KYC Level 1 Verification.",
  //                 textAlign: TextAlign.start,
  //                 style: TextStyle(
  //                     // fontFamily: 'Karla',
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.bold,
  //                     letterSpacing: .1,
  //                     height: 1.4,
  //                     color: Color.fromARGB(255, 49, 17, 34)),
  //               ),
  //               const SizedBox(height: 16),
  //               Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     SizedBox(height: 8.h),
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                           child: OutlineBtn(
  //                             onPressed: () {
  //                               viewModel.navigationService.back();
  //                             },
  //                             text: "Reject",
  //                             textColor: Color.fromARGB(255, 49, 17, 34),
  //                             borderColor: Color.fromARGB(255, 49, 17, 34),
  //                           ),
  //                         ),
  //                         horizontalSpaceSmall,
  //                         Expanded(
  //                           child: FilledBtn(
  //                             onPressed: () {
  //                               // viewModel.navigationService
  //                               //     .clearStackAndShow(Routes.authLoginView);
  //                             },
  //                             backgroundColor: Color(0xffff0082),
  //                             text: "Accept",
  //                             textColor: Colors.white,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(height: 24.h),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  TabHomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TabHomeViewModel();

  @override
  void onViewModelReady(TabHomeViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }
}
