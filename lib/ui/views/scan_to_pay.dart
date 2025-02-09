import 'package:dayfi/ui/common/transaction.dart';
import 'package:dayfi/ui/common/valid_card_snack.dart';
import 'package:dayfi/ui/views/card_pin_entry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ml_card_scanner/ml_card_scanner.dart';

class ScanToPay extends StatefulWidget {
  final double amount;
  final TransactionService transactionService;
  const ScanToPay(
      {super.key, required this.amount, required this.transactionService});

  @override
  State<ScanToPay> createState() => _ScanToPayState();
}

class _ScanToPayState extends State<ScanToPay> {
  final ScannerWidgetController controller = ScannerWidgetController();

  @override
  void initState() {
    controller
      ..setCardListener(onListenCard)
      ..setErrorListener(onError);
    super.initState();
  }

  @override
  void dispose() {
    controller
      ..removeCardListeners(onListenCard)
      ..removeErrorListener(onError)
      ..dispose();
    super.dispose();
  }

  void onListenCard(CardInfo? value) {
    if (value != null) {
      showDebitCardValidSnackbar(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CardPinEntry(
                    amount: widget.amount,
                    transactionService: widget.transactionService,
                  )));
    }
  }

  void onError(ScannerException exception) {
    if (kDebugMode) {
      print('Error: ${exception.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.background,
      body: ScannerWidget(
        controller: controller,
        overlayOrientation: CardOrientation.landscape,
        cameraResolution: CameraResolution.high,
        oneShotScanning: true,
      ),
    );
  }
}
