import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'package:partner_dashboard_web_app/common/common_widget/shimmer.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';

import 'dashboard_data_widget.dart';
import 'dashboard_filter_widget.dart';
import 'dashboard_tab_widget.dart';

class DashboardWidget extends StatelessWidget {
  final DashBoardController controller;
  const DashboardWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(left: 18),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: ColorConstant.surface.withValues(alpha: 0.45),
          border: Border.all(color: ColorConstant.border),
          boxShadow: [
            BoxShadow(
              blurRadius: 40,
              offset: const Offset(0, 20),
              color: Colors.black.withValues(alpha: 0.26),
            ),
          ],
        ),
        child: controller.isLoading.value == true &&
                controller.partnerMoviesList.isEmpty
            ? const ShimmerLoading()
            : Column(
                children: [
                  DashboardFilterWidget(controller: controller),
                  const SizedBox(height: 14),
                  const DashboardTabWidget(),
                  const SizedBox(height: 14),
                  DashboardDataWidget(controller: controller),
                ],
              ),
      ),
    );
  }
}
