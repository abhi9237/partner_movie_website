import 'package:flutter/cupertino.dart';
import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';


class DashboardTabWidget extends StatelessWidget {
  const DashboardTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DashBoardTopWidget();
  }
}

class DashBoardTopWidget extends StatelessWidget {
  const DashBoardTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50,vertical: 18),
      margin: EdgeInsets.only(left: 20,right: 20,top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorConstant.whiteColor,
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Product',
              style: appStyle(responsive(context, 12,desktop: 14,tablet: 12), color: ColorConstant.darkColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Expanded(
            child: Text(
              'Content Length',
              style: appStyle(responsive(context, 12,desktop: 14,tablet: 12), color: ColorConstant.darkColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              'Watch Hours',
              style: appStyle(responsive(context, 12,desktop: 14,tablet: 12), color: ColorConstant.darkColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              'Watch Minutes',
              style: appStyle(responsive(context, 12,desktop: 14,tablet: 12), color: ColorConstant.darkColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              'Content Views',
              style: appStyle(responsive(context, 12,desktop: 14,tablet: 12), color: ColorConstant.darkColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
