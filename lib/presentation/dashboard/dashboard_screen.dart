import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';
import 'package:partner_dashboard_web_app/presentation/dashboard/widget/dashboard_widget.dart';
import 'package:partner_dashboard_web_app/presentation/dashboard/widget/product_detail/product_detail.dart';
import '../../common/common_widget/drawer_widget.dart';
import '../partner_profile/partner_profile.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
      init: DashBoardController(context: context),
      builder: (controller) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.4,
                colors: [
                  Color(0xFF0C1830),
                  ColorConstant.background,
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -120,
                  right: -100,
                  child: _GlowBlob(color: ColorConstant.appColor.withValues(alpha: 0.20)),
                ),
                Positioned(
                  bottom: -140,
                  left: -90,
                  child: _GlowBlob(color: ColorConstant.accentRose.withValues(alpha: 0.14)),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile(context) ? 12 : 18,
                      vertical: isMobile(context) ? 12 : 18,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (!isMobile(context)) DrawerWidget(controller: controller),
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 280),
                            child: controller.selectedDrawerIndex.value == 0
                                ? (controller.isShowProductDetail.value
                                    ? ProductDetailScreen(controller: controller)
                                    : DashboardWidget(controller: controller))
                                : ProfileScreen(controller: controller),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GlowBlob extends StatelessWidget {
  final Color color;
  const _GlowBlob({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 260,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}
