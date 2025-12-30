import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';
import '../../../../common/common_chart_widget/chart_widget.dart';
import '../../../../common/common_methods/responsive.dart';
import '../../../../core/bar_data/bar_data.dart';
import '../../../../core/grouth_data/growth_data.dart';

class ProductDetailChartWidget extends StatelessWidget {
  final DashBoardController controller;

  const ProductDetailChartWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: context.height * 0.8,
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
        children: [
          Expanded(
            child: CommonChartWidget(
              chartType: ChartType.bar,
              width: context.width * 0.8,
              title: "Weekly Watch Time",
              height: context.height * 0.28,
              barData:controller.buildWeeklyBarData(controller.weeklyWatchTimeList),
            ),
          ),
          SizedBox(height: 20),

          // CommonChartWidget(
          //   chartRadius: 120,
          //   chartType: ChartType.pie,
          //   title: "Content Distribution",
          //   pieData: const [
          //     PieData(name: "Videos", percent: 40, color: Colors.blueAccent),
          //     PieData(name: "Articles", percent: 30, color: Colors.orangeAccent),
          //     PieData(name: "Quizzes", percent: 20, color: Colors.greenAccent),
          //     PieData(name: "Others", percent: 10, color: Colors.redAccent),
          //   ],
          // ),
          // Example 2: CIRCULAR GROWTH CHART
          CommonChartWidget(
            height: context.height * 0.2,
            chartType: ChartType.circularGrowth,
            title: "Content Views",
            growthData: GrowthData(
              title: "Total Content View",
              value:
                  double.tryParse(
                    controller.partnerMovieDetailData.value.viewCount
                        .toString(),
                  ) ??
                  0,
              color: Colors.purple,
            ),
            chartRadius: 60, // Slightly smaller radius
          ),

          // Example 3: Another Growth Chart
          // CommonChartWidget(
          //   chartType: ChartType.circularGrowth,
          //   title: "Server Load",
          //   growthData: const GrowthData(
          //     title: "CPU Usage",
          //     value: 45,
          //     color: Colors.teal,
          //   ),
          //   chartRadius: 70,
          // ),
        ],
      ),
    );
  }
}
