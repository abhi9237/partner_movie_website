import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/image_constant/image_constant.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';
import '../common_methods/responsive.dart';
import 'common_widget.dart';

class DrawerWidget extends StatelessWidget {
  final DashBoardController controller;
  const DrawerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.black,
        gradient: LinearGradient(
          colors: [
            Colors.black.withValues(alpha: 0.5),
            Colors.grey.withValues(alpha: 0.2),
            Colors.black.withValues(alpha: 0.1),
            Colors.grey.withValues(alpha: 0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            spreadRadius: 2,
            color: isMobile(context)
                ? Colors.transparent
                : Colors.blueAccent.withValues(alpha: 0.1),
          ),
        ],
      ),

      child: Column(
        spacing: 20,
        children: [
          DashBoardAppBar(),
          SizedBox(height: 20),
          MenuButtonWidget(
            selectedIndex: controller.selectedDrawerIndex.value,
            index: 0,
            text: 'Dashboard',
            icon: Icons.dashboard,
            onTap: () {
              controller.onTapSelectDrawer(0);
            },
          ),
          MenuButtonWidget(
            index: 1,
            text: 'Profile',
            icon: Icons.person,
            selectedIndex: controller.selectedDrawerIndex.value,
            onTap: () {
              controller.onTapSelectDrawer(1);
            },
          ),
          Spacer(),
          LogOutWidget(text: 'Logout', icon: Icons.logout,onTap: (){
            showLogoutPopup(context);
          },),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}

class DashBoardAppBar extends StatelessWidget {
  const DashBoardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: context.width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

      child: Row(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.oceaniekLogo,
            height: 40,
            width: 150,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

class MenuButtonWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final int index;
  final int selectedIndex;
  final VoidCallback? onTap;
  const MenuButtonWidget({
    super.key,
    required this.text,
    required this.icon,
    this.index = 0,
    this.selectedIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: context.width,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: index == selectedIndex
                ? [
                    ColorConstant.lightBlueGradient.withValues(alpha: 0.5),
                    ColorConstant.appColor.withValues(alpha: 0.1),
                  ]
                : [
                    Colors.black.withValues(alpha: 0.5),
                    Colors.grey.withValues(alpha: 0.1),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            Icon(icon, color: ColorConstant.whiteColor),
            Text(text, style: appStyle(16, color: ColorConstant.whiteColor)),
            Spacer(),
            index == selectedIndex
                ? Icon(Icons.navigate_next)
                : Icon(Icons.arrow_drop_down_sharp),
          ],
        ),
      ),
    );
  }
}

class LogOutWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final int index;
  final int selectedIndex;
  final VoidCallback? onTap;
  const LogOutWidget({
    super.key,
    required this.text,
    required this.icon,
    this.index = 0,
    this.selectedIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: context.width,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:  [
              Colors.red.withValues(alpha: 0.5),
              Colors.red.withValues(alpha: 0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            Icon(icon, color: ColorConstant.whiteColor),
            Text(text, style: appStyle(16, color: ColorConstant.whiteColor)),
            Spacer(),
            index == selectedIndex
                ? Icon(Icons.navigate_next)
                : Icon(Icons.arrow_drop_down_sharp),
          ],
        ),
      ),
    );
  }
}
