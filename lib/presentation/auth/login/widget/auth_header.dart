import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';

class AuthHeader extends StatelessWidget {
  final String headerTitle;
  final String headerSubTitle;
  const AuthHeader({
    super.key,
    required this.headerSubTitle,
    required this.headerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text:headerTitle,
                style: appStyle(
                  responsive(context, 35, tablet: 30, desktop: 40),
                  color: ColorConstant.appColor,
                ),
              ),
            ],
          ),
        ),

        Text(
          headerSubTitle,
          style: appStyle(
            fontWeight: FontWeight.w400,
            responsive(context, 16, tablet: 18, desktop: 18),
          ),
        ),
      ],
    );
  }
}
