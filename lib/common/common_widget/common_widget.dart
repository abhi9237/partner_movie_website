import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/config/route_constant/route_constant.dart';
import 'package:partner_dashboard_web_app/config/router/app_router.dart';

import '../../config/preference/shared_prefer.dart';
import '../theme/color_constant.dart';

void showToastMessage(BuildContext context, String message) {
  showToast(
    message,
    textStyle: appStyle(14),
    context: context,
    animation: StyledToastAnimation.slideFromTop,
    reverseAnimation: StyledToastAnimation.slideToTop,
    position: StyledToastPosition.top,
    startOffset: const Offset(0.0, -3.0),
    reverseEndOffset: const Offset(0.0, -3.0),
    duration: const Duration(seconds: 4),
    //Animation duration   animDuration * 2 <= duration
    animDuration: const Duration(seconds: 1),
    curve: Curves.elasticOut,
    reverseCurve: Curves.fastOutSlowIn,
  );
}

void showLogoutPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: ColorConstant.darkColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Logout',
          style: appStyle(
            20,
            color: ColorConstant.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: appStyle(16, color: Colors.grey.shade300,fontWeight: FontWeight.w400),
        ),
        actions: [
          // "Cancel" button
          TextButton(
            onPressed: () {
              dialogContext.pop();
            },
            child: Text(
              'Cancel',
              style: appStyle(14, color: Colors.grey.shade400),
            ),
          ),
          // "Logout" button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              await StorageService.clearAll();
              context.goNamed(RouteConstant.login);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text(
                'Logout',
                style: appStyle(
                  14,
                  color: ColorConstant.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
