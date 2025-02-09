// import 'package:epass/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinTextField extends StatelessWidget {
  final Function(String)? onTextChanged;
  final Function()? onCancel;
  final Function(String)? onCompleted;
  final TextEditingController? controller;
  final bool isEnabled;
  final double? height;
  final double? width;
  final int length;
  final bool obscureText;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  const PinTextField({
    super.key,
    this.onTextChanged,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.isEnabled = true,
    this.height,
    this.width,
    this.length = 4,
    this.onCancel,
    this.onCompleted,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PinCodeTextField(
          keyboardType: TextInputType.number,
          focusNode: focusNode,
          enablePinAutofill: true,
          controller: controller,
          autoDisposeControllers: false,
          blinkDuration: const Duration(milliseconds: 10),
          enabled: isEnabled,
          validator: validator,
          cursorWidth: 1,
          enableActiveFill: true,
          obscureText: obscureText,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textStyle: TextStyle(
            fontSize: 18.sp,
            color: Color.fromARGB(255, 49, 17, 34),
            fontWeight: FontWeight.w700,
          ),
          pinTheme: PinTheme(
            errorBorderWidth: 1.5.w,
            activeBorderWidth: 1.5.w,
            disabledBorderWidth: 1.5.w,
            inactiveBorderWidth: 1.5.w,
            selectedBorderWidth: 1.5.w,
            borderWidth: 1.5.w,
            fieldHeight: height ?? 48.0.w,
            fieldWidth: width ?? 40.0.w,
            borderRadius: BorderRadius.circular(4.r),
            shape: PinCodeFieldShape.box,
            inactiveFillColor: Colors.white,
            activeFillColor: Color.fromARGB(255, 49, 17, 34).withOpacity(.1),
            selectedFillColor: Color.fromARGB(255, 49, 17, 34).withOpacity(.05),
            inactiveColor: Color.fromARGB(255, 49, 17, 34).withOpacity(.2),
            activeColor: Color.fromARGB(255, 49, 17, 34),
            selectedColor: Color.fromARGB(255, 49, 17, 34),
          ),
          appContext: context,
          length: length,
          onCompleted: onCompleted,
          onChanged: onTextChanged!,
          animationType: AnimationType.fade,
          animationDuration: const Duration(milliseconds: 150),
          cursorColor: Color.fromARGB(255, 49, 17, 34),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ],
    );
  }
}
