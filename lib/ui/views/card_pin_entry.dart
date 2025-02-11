import 'dart:developer';

import 'package:dayfi/ui/common/transaction.dart';
import 'package:dayfi/ui/views/success_view.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CardPinEntry extends StatefulWidget {
  final double amount;
  final TransactionService transactionService;

  const CardPinEntry({
    super.key,
    required this.amount,
    required this.transactionService,
  });

  @override
  State<CardPinEntry> createState() => _CardPinEntryState();
}

class _CardPinEntryState extends State<CardPinEntry> {
  String _enteredPin = "";
  bool isLoading = false;

  int _pinAttempts = 0;
  DateTime? _lockoutEndTime;

  bool get isPinLocked =>
      _lockoutEndTime != null && DateTime.now().isBefore(_lockoutEndTime!);

  int get remainingAttempts => 3 - _pinAttempts;

  void resetPinAttempts() {
    setState(() {
      _pinAttempts = 0;
      _lockoutEndTime = null;
    });
  }

  String? getRemainingLockoutTime() {
    if (!isPinLocked) return null;
    final remaining = _lockoutEndTime!.difference(DateTime.now());
    return '${remaining.inMinutes}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void _onKeyPressed(String value) async {
    if (value == "CLEAR" || value == "CANCEL") {
      setState(() => _enteredPin = "");
      return;
    }

    if (value == "ENTER") {
      if (isPinLocked) {
        _showLockDialog();
        return;
      }

      setState(() => isLoading = true);

      if (_enteredPin == "5555") {
        await _processValidPin();
      } else {
        _handleInvalidPin();
      }

      if (mounted) {
        setState(() => isLoading = false);
      }
      return;
    }

    if (_enteredPin.length < 4) {
      setState(() => _enteredPin += value);
    }
  }

  void _showLockDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('PIN Locked',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Color(0xFF311122))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Too many incorrect attempts. Please wait:',
                style: TextStyle(color: Color(0xFF311122))),
            const SizedBox(height: 8),
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                final remainingTime = getRemainingLockoutTime() ?? 'Locked';
                return Text(
                  remainingTime,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor)),
          ),
        ],
      ),
    );
  }

  Future<void> _processValidPin() async {
    resetPinAttempts();

    await widget.transactionService.addTransaction(
      type: 'FUND',
      amount: widget.amount,
      fromCurrency: 'BANK',
      toCurrency: 'NGN',
    );

    double beforeCurrentBalance = widget.transactionService.getNairaBalance();
    log(beforeCurrentBalance.toString());

    // await widget.transactionService
    //     .updateNairaBalance(widget.amount);

    double afterCurrentBalance = widget.transactionService.getNairaBalance();
    log(afterCurrentBalance.toString());

    await Future.delayed(const Duration(milliseconds: 2000));

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SuccessView(amount: widget.amount)),
      );
    }
  }

  void _handleInvalidPin() {
    _pinAttempts++;

    if (_pinAttempts >= 3) {
      setState(() =>
          _lockoutEndTime = DateTime.now().add(const Duration(minutes: 5)));
      _showLockDialog();
      return;
    }

    _showInvalidPinDialog();
  }

  void _showInvalidPinDialog() {
    final remainingAttempts = 3 - _pinAttempts;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Invalid PIN',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Color(0xFF311122))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('The PIN you entered is incorrect.',
                style: TextStyle(color: Color(0xFF311122))),
            const SizedBox(height: 8),
            Text(
              '$remainingAttempts attempts remaining',
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Try Again',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor)),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypad() {
    List<String> keys = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "CLEAR",
      "0",
      "ENTER",
    ];
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: keys.length,
      itemBuilder: (context, index) {
        return ElevatedButton(
          onPressed: () => _onKeyPressed(keys[index]),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: _getKeyColor(keys[index]),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            minimumSize: Size(44, 44),
            padding: EdgeInsets.all(12),
          ),
          child: Text(
            keys[index],
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 49, 17, 34)),
          ),
        );
      },
    );
  }

  Color _getKeyColor(String key) {
    if (key == "CANCEL") return Colors.red;
    if (key == "CLEAR") return Colors.orange.shade700;
    if (key == "ENTER") return Colors.green.shade700;
    return Colors.black12;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color(0xfff7f7f7),
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context)),
            backgroundColor: Color(0xfff7f7f7),
            title: Text(
              "PIN entry",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: false,
            elevation: 0,
          ),
          body: Center(
            child: Padding(
              // margin: EdgeInsets.symmetric(horizontal: 18.0.w),
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 18),
                  Text(
                    "NGN ${widget.amount.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 32,
                      height: 1.2,
                      color: Color.fromARGB(255, 49, 17, 34),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 72),
                  Spacer(),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${_enteredPin.replaceAll(RegExp(r"."), "*")}\n",
                        style: TextStyle(
                            fontSize: 24,
                            letterSpacing: 8,
                            color: Color.fromARGB(255, 49, 17, 34)),
                      ),
                      _buildKeypad(),
                    ],
                  ),
                  Spacer(),
                  Image.asset(
                    'assets/svgs/paystack-badge-cards-ngn.png',
                    width: 124,
                    color: Color.fromARGB(255, 49, 17, 34),
                  )
                ],
              ),
            ),
          ),
        ),
        if (isLoading == true) ...[const Loader()]
      ],
    );
  }

  Widget textWidget(text) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4,
        bottom: 4,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          height: 1.4,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0xfff7f7f7),
      body: Center(
        child: Container(
          width: 50.0,
          height: 50.0,
          alignment: Alignment.center,
          child: const LoadingIndicator(
              indicatorType: Indicator.ballRotateChase,
              colors: [
                Color(0xffff0082),
              ],
              strokeWidth: 5.0,
              pathBackgroundColor: Colors.black),
        ),
      ),
    );
  }
}

// First, create a reusable error dialog
void showInvalidPinDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Invalid PIN',
          style: TextStyle(
            color: Color.fromARGB(255, 49, 17, 34),
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'The PIN you entered is incorrect. Please try again. \n\n 4 more tries.',
          style: TextStyle(
            color: Color.fromARGB(255, 49, 17, 34).withOpacity(0.8),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    },
  );
}
