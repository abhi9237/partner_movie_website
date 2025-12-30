import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';

class DashboardFilterWidget extends StatelessWidget {
  final DashBoardController controller;
  const DashboardFilterWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              'DashBoard',
              style: appStyle(20, color: ColorConstant.whiteColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          isMobile(context) || isTablet(context)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DashboardCalenderWidget(
                      dateText: controller.dateRangeText,
                      onTap: () {
                        controller.selectDateRange(context,controller.selectedProductId.value);
                      },
                    ),
                    SizedBox(height: 20),
                    DashboardTextFilledWidget(
                      isShowClearButton:controller.isShowCloseButton.value ,
                      controller: controller.searchController.value,
                      onChanged: controller.onChangedTextFilled,
                      onTapClose: controller.onTapCloseTextFilled,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DashboardTextFilledWidget(
                      isShowClearButton: controller.isShowCloseButton.value,
                      controller: controller.searchController.value,
                      onChanged: controller.onChangedTextFilled,
                      onTapClose: controller.onTapCloseTextFilled,
                    ),
                    DashboardCalenderWidget(
                      dateText: controller.dateRangeText,
                      onTap: () {
                        controller.selectDateRange(context,controller.selectedProductId.value);
                      },
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class DashboardCalenderWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String dateText;
  const DashboardCalenderWidget({
    super.key,
    required this.onTap,
    required this.dateText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(right: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorConstant.whiteColor,
        ),
        height: 45,
        width: dateText.toLowerCase() == 'Select Date'.toLowerCase()
            ? 150
            : 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(dateText, style: appStyle(12, color: ColorConstant.darkColor)),
            Icon(
              Icons.calendar_month,
              color: ColorConstant.darkColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardTextFilledWidget extends StatelessWidget {
  final VoidCallback onTapClose;
  final Function(String) onChanged;
  final TextEditingController controller;
  final bool isShowClearButton;
  const DashboardTextFilledWidget({
    super.key,
    required this.onTapClose,
    required this.onChanged,
    required this.controller,
    required this.isShowClearButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: isMobile(context) || isTablet(context) ? 30 : 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstant.whiteColor,
      ),
      height: 45,
      width: responsive(
        context,
        context.width * 0.5,
        desktop: 300,
        tablet: context.width * 0.2,
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: appStyle(12, color: ColorConstant.darkColor),
        cursorColor: ColorConstant.blueGradient,
        decoration: InputDecoration(
          hintText: 'Search Movie....',
          suffixIcon: isShowClearButton
              ? GestureDetector(
                  onTap: onTapClose,
                  child: Icon(Icons.close, color: ColorConstant.darkColor,size: 18,),
                )
              : SizedBox(),
          contentPadding: EdgeInsets.only(bottom: 2, left: 15, right: 15),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorConstant.whiteColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorConstant.whiteColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorConstant.whiteColor),
          ),
        ),
      ),
    );
  }
}
