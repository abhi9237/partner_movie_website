import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/presentation/dashboard/widget/dashboard_widget.dart';
import 'package:partner_dashboard_web_app/presentation/dashboard/widget/product_detail/product_detail.dart';
import '../../common/common_widget/drawer_widget.dart';
import '../../controller/dashboard_controller.dart';
import '../partner_profile/partner_profile.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
      init: DashBoardController(context: context),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                if (!isMobile(context)) DrawerWidget(controller: controller),
                controller.selectedDrawerIndex.value == 0
                    ? controller.isShowProductDetail.value == true
                          ? ProductDetailScreen(controller: controller)
                          : DashboardWidget(controller: controller)
                    : controller.selectedDrawerIndex.value == 1
                    ? ProfileScreen(controller: controller,)
                    : SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
