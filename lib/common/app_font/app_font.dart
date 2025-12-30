import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/color_constant.dart';

TextStyle appStyle(double fontSize, {FontWeight? fontWeight, Color? color}) {
  return GoogleFonts.aBeeZee(
    fontSize: fontSize,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: color ?? ColorConstant.whiteColor,
  );
}
