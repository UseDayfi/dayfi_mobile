import 'package:dayfi/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final TextInputFormatter? formatter;
  final Function(String)? onChanged;
  final Function()? onTap;
  final int? maxLength;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? borderColor;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool shouldReadOnly;
  final bool enabled;
  final TextCapitalization? textCapitalization;
  final int? minLines;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final bool enableInteractiveSelection;
  final Widget? prefix;

  const CustomTextField({
    super.key,
    this.label,
    this.keyboardType,
    this.obscureText = false,
    this.hintText,
    this.formatter,
    this.onChanged,
    this.onTap,
    this.maxLength,
    this.suffixIcon,
    this.prefixIcon,
    this.borderColor,
    this.controller,
    this.validator,
    this.shouldReadOnly = false,
    this.enabled = true,
    this.minLines,
    this.textCapitalization,
    this.textInputAction,
    this.autofocus = true,
    this.enableInteractiveSelection = true,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: TextStyle(
            // fontFamily: 'Karla',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: .1,
            height: 1.4,
            color:
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.95),
          ),
          textAlign: TextAlign.start,
        ),
        verticalSpace(8),
        TextFormField(
          // autofocus: autofocus,
          maxLines: minLines,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          onTap: onTap,
          enableInteractiveSelection: enableInteractiveSelection,
          textCapitalization:
              textCapitalization ?? TextCapitalization.sentences,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLength: obscureText ? null : maxLength,
          controller: controller,
          cursorColor: Color(0xffff0082),
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          readOnly: shouldReadOnly,
          obscureText: obscureText,
          onChanged: onChanged,
          validator: validator,
          inputFormatters: [
            formatter ?? FilteringTextInputFormatter.singleLineFormatter,
          ],
          style: TextStyle(
            // fontFamily: 'Karla',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.4,
            color: Color.fromARGB(255, 49, 17, 34),
          ),
          decoration: InputDecoration(
            counterText: "",
            hintText: hintText,
            hintStyle: TextStyle(
              // fontFamily: 'Karla',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.4,
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  // ignore: deprecated_member_use
                  .withOpacity(.75),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 14.w,
            ),
            errorStyle: const TextStyle(
              fontSize: 12,
              color: Colors.red,
              letterSpacing: -.3,
            ),
            prefixIcon: prefixIcon,
            prefix: prefix,
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                // color: Color(0xffff0082),
                color: Color.fromARGB(255, 49, 17, 34),
                width: 1.5.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 49, 17, 34).withOpacity(.2),
                width: 1.5.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 1.5.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 1.5.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextField2 extends StatelessWidget {
  final String? label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final TextInputFormatter? formatter;
  final Function(String)? onChanged;
  final Function()? onTap;
  final int? maxLength;
  final Widget? suffixIcon;
  final Color? borderColor;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool shouldReadOnly;
  final bool enabled;
  final TextCapitalization? textCapitalization;
  final int? minLines;
  final TextInputAction? textInputAction;
  final bool autofocus;

  const CustomTextField2({
    super.key,
    this.label,
    this.keyboardType,
    this.obscureText = false,
    this.hintText,
    this.formatter,
    this.onChanged,
    this.onTap,
    this.maxLength,
    this.suffixIcon,
    this.borderColor,
    this.controller,
    this.validator,
    this.shouldReadOnly = false,
    this.enabled = true,
    this.minLines,
    this.textCapitalization,
    this.textInputAction,
    this.autofocus = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          // autofocus: autofocus,
          maxLines: minLines,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          onTap: onTap,
          textCapitalization:
              textCapitalization ?? TextCapitalization.sentences,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLength: obscureText ? null : maxLength,
          controller: controller,
          cursorColor: Color(0xffff0082),
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          readOnly: shouldReadOnly,
          obscureText: obscureText,
          onChanged: onChanged,
          validator: validator,
          inputFormatters: [
            formatter ?? FilteringTextInputFormatter.singleLineFormatter,
          ],
          style: TextStyle(
            // fontFamily: 'Karla',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.4,
            color: Color.fromARGB(255, 49, 17, 34),
          ),
          decoration: InputDecoration(
            counterText: "",
            hintText: hintText,
            hintStyle: TextStyle(
              // fontFamily: 'Karla',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.4,
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  // ignore: deprecated_member_use
                  .withOpacity(.75),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 14.w,
            ),
            errorStyle: const TextStyle(
              fontSize: 12,
              color: Colors.red,
              letterSpacing: -.3,
            ),
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                // color: Color(0xffff0082),
                color: Color.fromARGB(255, 49, 17, 34),
                width: 1.5.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 49, 17, 34).withOpacity(.2),
                width: 1.5.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 1.5.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 1.5.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final List<String> items;
  final String? selectedValue;
  final Function(String?)? onChanged;
  final Function()? onTap;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool enabled;

  const CustomDropdownField({
    super.key,
    this.label,
    this.hintText,
    required this.items,
    this.selectedValue,
    this.onChanged,
    this.onTap,
    this.suffixIcon,
    this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: TextStyle(
            // fontFamily: 'Karla',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: .1,
            height: 1.4,
            color: Color.fromARGB(255, 49, 17, 34),
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue,
          onChanged: onChanged,
          onTap: onTap,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 14,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              // fontFamily: 'Karla',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: .1,
              height: 1.4,
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .color!
                  .withOpacity(.75),
            ),
            suffixIcon: suffixIcon ?? Icon(Icons.keyboard_arrow_down),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 49, 17, 34),
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 49, 17, 34).withOpacity(.2),
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
