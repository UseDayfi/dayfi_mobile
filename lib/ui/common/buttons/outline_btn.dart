// import 'package:blyr/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutlineBtn extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? textColor;
  final Color? borderColor;
  final bool hasIcon;
  final Widget? icon;

  const OutlineBtn({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor,
    this.borderColor,
    this.hasIcon = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          side: WidgetStateProperty.all(
            BorderSide(
              width: 1,
              color: borderColor ?? Color(0xffff0082),
            ),
          ),
        ),
        onPressed: onPressed,
        child: hasIcon
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon!,
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: TextStyle(
                      // fontFamily: 'Karla',
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0,
                      height: 1.4,
                      color: textColor,
                    ),
                  ),
                ],
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
