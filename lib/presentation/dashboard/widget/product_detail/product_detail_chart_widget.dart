import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_chart_widget/chart_widget.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';

class ProductDetailChartWidget extends StatelessWidget {
  final DashBoardController controller;

  const ProductDetailChartWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            ColorConstant.surfaceStrong.withValues(alpha: 0.9),
            ColorConstant.surfaceElevated.withValues(alpha: 0.72),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: ColorConstant.borderMuted),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Watch time',
                    style: appStyle(
                      22,
                      color: ColorConstant.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Weekly trend for the selected content',
                    style: appStyle(
                      13,
                      color: ColorConstant.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _LegendDot(color: ColorConstant.appColor, label: 'Watch minutes'),
            ],
          ),
          const SizedBox(height: 20),
          Obx(
            () => CommonChartWidget(
              selectedStartDate: controller.selectedStartDate,
              selectedEndDate: controller.selectedEndDate,
              chartType: ChartType.bar,
              width: context.width * 0.82,
              title: 'Watch Time',
              height: context.height * 0.28,
              barData: controller.buildWeeklyBarData(
                controller.weeklyWatchTimeList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: appStyle(
              12,
              color: ColorConstant.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
