import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts_arabic/fonts.dart';

TextStyle textStyleCairo = TextStyle(
    fontFamily: ArabicFonts.Cairo,
    package: 'google_fonts_arabic',
    fontWeight: FontWeight.bold);

TextStyle profileTextStyleCairo = TextStyle(
    fontFamily: ArabicFonts.Cairo,
    package: 'google_fonts_arabic',
    fontSize: 20,
    fontWeight: FontWeight.bold);

customeText(
  String txt,
) {
  return Text(txt,
      style: TextStyle(
          fontFamily: ArabicFonts.Cairo,
          package: 'google_fonts_arabic',
          fontWeight: FontWeight.bold));
}
