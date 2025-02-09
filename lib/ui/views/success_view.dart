import 'package:dayfi/ui/common/buttons/outline_btn.dart';
import 'package:dayfi/ui/views/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessView extends StatefulWidget {
  final double amount;
  const SuccessView({super.key, required this.amount});

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 49, 17, 34).withOpacity(.2),
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .05),
          _buildBody(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildNextStepButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset("assets/svgs/successcheck.svg"),
        SizedBox(height: 18),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "payment received",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    letterSpacing: .2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  "The sum of NGN ${widget.amount.toStringAsFixed(2)} have been received successfully",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNextStepButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 32.0),
      child: SizedBox(
        child: OutlineBtn(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainView(),
                ));
          },
          text: "Go Home",
          textColor: Color.fromARGB(255, 49, 17, 34),
          borderColor: Color.fromARGB(255, 49, 17, 34),
        ),
      ),
    );
  }
}
