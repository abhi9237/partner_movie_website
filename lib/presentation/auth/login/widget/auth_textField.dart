import 'package:country_code_picker/country_code_picker.dart';
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
      hintText: 'Enter mobile number',
      controller: textEditingController,
      prefixIcon: Container(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                dialogBackgroundColor: ColorConstant.darkColor,
                canvasColor: ColorConstant.darkColor,
                textTheme: const TextTheme(
                  bodyMedium: TextStyle(color: Colors.white),
                ),
              ),
              child: CountryCodePicker(
                onChanged: onChanged,
                initialSelection: 'IN',
                favorite: const ['+91', '+1'],

                // Layout
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,

                // Dialog Styling
                dialogBackgroundColor: ColorConstant.darkColor,
                barrierColor: Colors.black.withOpacity(0.7),

                // Text Styling
                textStyle: appStyle(14, color: Colors.white),
                dialogTextStyle: appStyle(16, color: Colors.white),
                searchStyle: appStyle(16, color: Colors.white),

                // Search Field Decoration
                searchDecoration: InputDecoration(
                  hintText: "Search country",
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: ColorConstant.darkColor.withOpacity(0.8),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),

                // Dialog Size
                dialogSize: Size(
                  responsive(
                    context,
                    context.width * 0.9,
                    desktop: context.width * 0.35,
                    tablet: context.width * 0.45,
                  ),
                  responsive(
                    context,
                    context.height * 0.6,
                    desktop: context.height * 0.65,
                    tablet: context.height * 0.55,
                  ),
                ),

                // Optional: flag + code color fix
                flagDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Container(
              height: 24,
              width: 1,
              color: ColorConstant.borderMuted,
            ),
          ],
        ),
      ),
    );
  }
}
