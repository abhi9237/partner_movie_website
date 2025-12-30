import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/common_textform_field/common_text_form_filled.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final VoidCallback? onTapPrefixIcon;
  final Function(CountryCode)? onChanged;
  const AuthTextField({
    super.key,
    required this.textEditingController,
    this.onTapPrefixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CommonTextFormFilled(
      inputFormatter: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      hintText: 'Mobile number',
      controller: textEditingController,
      prefixIcon: InkWell(
        onTap: onTapPrefixIcon,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CountryCodePicker(
                barrierColor: ColorConstant.darkColor,
                backgroundColor: ColorConstant.darkColor,
                onChanged: onChanged,
                favorite: ['+39', 'FR'],
                initialSelection: 'IN',
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                searchStyle: appStyle(18, color: ColorConstant.darkColor),
                dialogTextStyle: appStyle(18, color: ColorConstant.darkColor),
                dialogSize: Size(
                  responsive(
                    context,
                    context.width * 0.5,
                    desktop: context.width * 0.5,
                    tablet: context.width * 0.5,
                  ),
                  responsive(
                    context,
                    context.height * 0.5,
                    desktop: context.height * 0.5,
                    tablet: context.height * 0.5,
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 2,
                color: ColorConstant.lightGreyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
