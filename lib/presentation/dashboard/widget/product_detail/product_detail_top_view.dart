import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';

import '../dashboard_filter_widget.dart';

class ProductDetailTopView extends StatelessWidget {
  final DashBoardController controller;
  const ProductDetailTopView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, left: 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.onTapProductBackButton();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: ColorConstant.whiteColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Product detail',
              style: appStyle(20, color: ColorConstant.whiteColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          DashboardCalenderWidget(
            dateText: controller.dateRangeText,
            onTap: () {
              controller.selectDateRange(
                context,
                controller.selectedProductId.value,
              );
            },
          ),
        ],
      ),
    );
  }
}
