import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts_arabic/fonts.dart';

class PasswordTextView extends StatefulWidget {
  final String? hintText, msgRequired, msgInvalid, filedSize;
  final TextInputType? textInputType;
  final bool? obscureText;
  final double? fontSize;
  final TextEditingController? controller;
  final bool? enabled;
  final ValueChanged<String>? onChanged;

  const PasswordTextView({
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
  State<PasswordTextView> createState() => _PasswordTextViewState();
}

bool _obscureText = true;

class _PasswordTextViewState extends State<PasswordTextView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        enabled: widget.enabled,
        keyboardType: widget.textInputType,
        onChanged: widget.onChanged,
        controller: widget.controller,
        obscureText: _obscureText,
        textInputAction: TextInputAction.next,
        style: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
            color: Theme.of(context).indicatorColor,
            fontSize: 16,
            height: .9),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
            color: Theme.of(context).indicatorColor,
            fontSize: 16,
            height: .9),
            labelText: widget.hintText,
            suffixIcon: IconButton(
              icon: Icon(
                !_obscureText ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).indicatorColor,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )),
      ),
    );
  }
}
