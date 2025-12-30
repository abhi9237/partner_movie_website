import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';

import '../app_font/app_font.dart';

class CommonTextFormFilled extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? isObscureText;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatter;
  const CommonTextFormFilled({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText,
    this.prefixIcon,
     this.inputFormatter
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: responsive(
        context,
        isMobile(context) ? context.width : context.width * 0.45,
        desktop: 500,
        tablet: 500,
      ),
      child: TextFormField(
        obscureText: isObscureText ?? false,
        controller: controller,
        inputFormatters: inputFormatter,
        decoration: InputDecoration(

          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: appStyle(
            16,
            fontWeight: FontWeight.w400,
            color: ColorConstant.lightGreyColor,
          ),
        ),
      ),
    );
  }
}
