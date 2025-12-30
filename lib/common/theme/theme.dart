
import 'package:flutter/material.dart';


import 'color_constant.dart';

class AppTheme {
  static _border({Color color = ColorConstant.lightGreyColor}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: 2),
      );

  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorConstant.darkColor,
    appBarTheme: AppBarTheme(color: ColorConstant.darkColor),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(20),
      enabledBorder: _border(color: ColorConstant.lightGreyColor),
      focusedBorder: _border(color: ColorConstant.appColor),
    ),
  );
}
