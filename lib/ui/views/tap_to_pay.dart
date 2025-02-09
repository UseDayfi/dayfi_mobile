import 'package:dayfi/ui/common/buttons/outline_btn.dart';
import 'package:dayfi/ui/common/transaction.dart';
import 'package:dayfi/ui/common/valid_card_snack.dart';
import 'package:dayfi/ui/views/card_pin_entry.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TapToPay extends StatefulWidget {
  final double amount;
  final TransactionService transactionService;
  const TapToPay(
      {super.key, required this.amount, required this.transactionService});

  @override
  State<TapToPay> createState() => _TapToPayState();
}

class _TapToPayState extends State<TapToPay> {
  @override
  void initState() {
    Future.delayed(
        Duration(seconds: 5),
        () => {
              showDebitCardValidSnackbar(context),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardPinEntry(
                      amount: widget.amount,
                      transactionService: widget.transactionService,
                    ),
                  )),
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(),
            const SizedBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // NFC Animation
                Lottie.asset(
                  'assets/svgs/Animation - 1739115915964.json', // Your Lottie animation

                  fit: BoxFit.cover,
                ),

                const SizedBox(height: 40),

                // Payment Amount
                Text(
                  "NGN ${widget.amount.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 32,
                    height: 1.2,
                    color: Color.fromARGB(255, 49, 17, 34),
                    // color: Color.fromARGB(255, 49, 17, 34),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                // Status Text
                Text(
                  "Hold your card near the reader",
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
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Image.asset(
              'assets/svgs/paystack-badge-cards-.png',
              width: MediaQuery.of(context).size.width * .5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: OutlineBtn(
                onPressed: () => Navigator.pop(context),
                text: "Cancel payment",
                textColor: Color.fromARGB(255, 49, 17, 34),
                borderColor: Color.fromARGB(255, 49, 17, 34),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
