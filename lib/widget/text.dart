import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts_arabic/fonts.dart';

class ValidateTextView extends StatelessWidget {
  final String? hintText, msgRequired, msgInvalid, filedSize;
  final TextInputType? textInputType;
  final bool? obscureText;
  final double? fontSize;
  final TextEditingController? controller;
  final bool? enabled;
  final ValueChanged<String>? onChanged;

  const ValidateTextView({
    Key? key,
    this.hintText,
    this.msgRequired,
    this.msgInvalid,
    this.filedSize,
    this.textInputType,
    this.obscureText,
    this.fontSize,
    this.onChanged,
    this.controller,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        enabled: enabled,
        keyboardType: textInputType,
        onChanged: onChanged,
        controller: controller,
        textAlign: TextAlign.right,
        textInputAction: TextInputAction.next,
        style: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
            color: Theme.of(context).indicatorColor,
            fontSize: fontSize ?? 16,
            height: .9),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: hintText,
          labelText: hintText,
          hintStyle: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: Theme.of(context).indicatorColor,
              fontSize: fontSize ?? 16,
              height: .9),
        ),
        validator: (value) {
          if (textInputType == TextInputType.emailAddress) {
            if (!GetUtils.isEmail(value!)) {
              return "يجب أدخال البريد بشكل صحيح";
            } else {
              return null;
            }
          } else {
            if (!GetUtils.isLengthLessThan(value, 1)) {
              return msgRequired;
            } else {
              return null;
            }
          }
        },
        onSaved: (val) {
          controller!.text = val!;
        },
      ),
    );
  }
}
