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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: ColorConstant.appColor.withValues(alpha: 0.12),
            border: Border.all(color: ColorConstant.appColor.withValues(alpha: 0.2)),
          ),
          child: Text(
            'Partner access',
            style: appStyle(
              12,
              color: ColorConstant.whiteColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          headerTitle,
          style: appStyle(
            responsive(context, 32, tablet: 34, desktop: 40),
            color: ColorConstant.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          headerSubTitle,
          style: appStyle(
            responsive(context, 15, tablet: 16, desktop: 17),
            color: ColorConstant.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
