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
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            ColorConstant.surfaceStrong.withValues(alpha: 0.92),
            ColorConstant.surfaceElevated.withValues(alpha: 0.72),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: ColorConstant.borderMuted),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.onTapProductBackButton,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
                border: Border.all(color: ColorConstant.borderMuted),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: ColorConstant.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product detail',
                  style: appStyle(
                    24,
                    color: ColorConstant.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Detailed watch performance and time range insights for the selected content.',
                  style: appStyle(
                    13,
                    color: ColorConstant.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
