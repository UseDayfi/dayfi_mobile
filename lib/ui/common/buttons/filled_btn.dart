// import 'package:blyr/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilledBtn extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final bool? isEnabled;
  final Function()? onPressed;
  final Color? borderColor;
  final double borderWidth;
  final bool isModelBusy;

  const FilledBtn({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.onPressed,
    this.backgroundColor,
    this.isEnabled = true,
    this.borderColor,
    this.borderWidth = 2.0,
    this.isModelBusy = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 48,
      duration: const Duration(milliseconds: 200),
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            backgroundColor ??
                (isEnabled == false ? Color(0xffff0082) : Color(0xffff0082)),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.all(Colors.transparent),
        ),
        onPressed: isEnabled == false ? () {} : onPressed,
        child: isModelBusy
            ? const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  // fontFamily: 'Karla',
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: .2,
                  height: 1.4,
                  color: textColor,
                ),
              ),
      ),
    );
  }
}
