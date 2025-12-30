import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:partner_dashboard_web_app/common/common_widget/shimmer.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';
import 'package:partner_dashboard_web_app/presentation/dashboard/widget/product_detail/product_detail_chart_widget.dart';
import 'package:partner_dashboard_web_app/presentation/dashboard/widget/product_detail/product_detail_top_view.dart';
import 'package:partner_dashboard_web_app/presentation/dashboard/widget/product_detail/product_tab_section.dart';

class ProductDetailScreen extends StatelessWidget {
  final DashBoardController controller;
  const ProductDetailScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => controller.isLoadingProductDetail.value == true
            ? ShimmerLoading(isProductDetailPage: true)
            : Column(
                children: [
                  ProductDetailTopView(controller: controller),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ProductTabSection(controller: controller),
                          SizedBox(height: 20),
                          ProductDetailChartWidget(controller: controller),
                          SizedBox(height: 20),
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
