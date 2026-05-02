import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'package:partner_dashboard_web_app/common/common_widget/shimmer.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';

import 'product_detail_chart_widget.dart';
import 'product_detail_top_view.dart';
import 'product_tab_section.dart';

class ProductDetailScreen extends StatelessWidget {
  final DashBoardController controller;
  const ProductDetailScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: ColorConstant.surface.withValues(alpha: 0.45),
        border: Border.all(color: ColorConstant.border),
      ),
      child: Obx(
        () => controller.isLoadingProductDetail.value
            ? const ShimmerLoading(isProductDetailPage: true)
            : Column(
                children: [
                  ProductDetailTopView(controller: controller),
                  const SizedBox(height: 18),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ProductTabSection(controller: controller),
                          const SizedBox(height: 18),
                          ProductDetailChartWidget(controller: controller),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
