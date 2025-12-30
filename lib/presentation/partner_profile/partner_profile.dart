import 'dart:developer';

import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';

import '../../common/app_font/app_font.dart';
import '../../common/theme/color_constant.dart';

class ProfileScreen extends StatelessWidget {
  final DashBoardController controller;
  const ProfileScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final phone = controller
        .partnerDetailData
        .value
        .results
        ?.firstOrNull
        ?.userPhoneNumber;

    return Expanded(
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          CustomImageView(
            radius: BorderRadius.circular(100),
            height: 150,
            width: 150,
            url:
                controller
                    .partnerDetailData
                    .value
                    .results
                    ?.firstOrNull
                    ?.thumbnailUrl ??
                '',
            fit: BoxFit.cover,
          ),

          if (phone != null && phone.isNotEmpty)
            Text(phone, style: appStyle(18, color: ColorConstant.whiteColor)),
          Text(
            controller.partnerDetailData.value.results?.firstOrNull?.name ?? '',
            style: appStyle(18, color: ColorConstant.whiteColor),
          ),

          Text(
            controller
                    .partnerDetailData
                    .value
                    .results
                    ?.firstOrNull
                    ?.description ??
                '',
            style: appStyle(
              16,
              color: ColorConstant.whiteColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
