import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/color_constant.dart';

TextStyle appStyle(
  double fontSize, {
  FontWeight? fontWeight,
  Color? color,
}) {
  return GoogleFonts.manrope(
    fontSize: fontSize,
    fontWeight: fontWeight ?? FontWeight.w600,
    color: color ?? ColorConstant.whiteColor,
    height: 1.2,
  );
}
