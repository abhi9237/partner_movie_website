import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import '../../core/bar_data/bar_data.dart';
import '../../core/grouth_data/growth_data.dart';
import '../../core/pie_data/pi_data.dart';

/// Enum to define the type of chart to display.
enum ChartType { pie, circularGrowth, bar }

/// A versatile and reusable chart widget that can display different chart types.
class CommonChartWidget extends StatefulWidget {
  final ChartType chartType;
  final List<PieData>? pieData;
  final GrowthData? growthData;
  final String title;
  final double chartRadius;
  final double? height;
  final double? width;
  final List<BarData>? barData;

  const CommonChartWidget({
    super.key,
    required this.chartType,
    required this.title,
    this.pieData,
    this.barData,
    this.growthData,
    this.width,
    this.height,
    this.chartRadius = 80.0, // Default radius for the chart
  });

  @override
  State<CommonChartWidget> createState() => _CommonChartWidgetState();
}

class _CommonChartWidgetState extends State<CommonChartWidget> {
  int? touchedIndex; // For handling touch interactions on pie chart

  @override
  Widget build(BuildContext context) {
    // Basic validation
    if (widget.chartType == ChartType.pie && widget.pieData == null) {
      return const Center(child: Text("Error: Pie data is missing."));
    }
    if (widget.chartType == ChartType.circularGrowth &&
        widget.growthData == null) {
      return const Center(child: Text("Error: Growth data is missing."));
    }

    return Card(
      elevation: 4,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Chart Title
            Text(widget.title, style: appStyle(20, color: Colors.white)),
            const SizedBox(height: 20),
            // The Chart itself
            SizedBox(
              height: widget.height ?? context.height * 0.2,
              width: widget.width ?? context.width * 0.2,
              child: _buildChart(),
            ),
            const SizedBox(height: 20),
            // The Legend (bottom part)
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  /// Builds the appropriate chart based on the [ChartType].
  Widget _buildChart() {
    switch (widget.chartType) {
      case ChartType.pie:
        return _buildPieChart();
      case ChartType.circularGrowth:
        return _buildCircularGrowthChart();
      case ChartType.bar: // Add the new case
        return _buildBarChart();
    }
  }

  /// Builds a standard Pie Chart.
  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = null;
                return;
              }
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        sectionsSpace: 2,
        centerSpaceRadius: 0, // A pie chart has no center space
        sections: List.generate(widget.pieData!.length, (i) {
          final isTouched = i == touchedIndex;
          final fontSize = isTouched ? 16.0 : 12.0;
          final radius = isTouched
              ? widget.chartRadius * 0.9
              : widget.chartRadius * 0.8;

          final data = widget.pieData![i];
          return PieChartSectionData(
            color: data.color,
            value: data.percent,
            title: '${data.percent.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
            ),
          );
        }),
      ),
    );
  }

  /// Builds a Circular Growth Chart (Radial Bar Chart).
  Widget _buildCircularGrowthChart() {
    final data = widget.growthData!;
    final progressPercentage = data.percentage;

    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: widget.chartRadius * 0.7, // Large center space
        sections: [
          // The main progress section
          PieChartSectionData(
            // badgeWidget: Container(
            //   padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            //   decoration: BoxDecoration(color: ColorConstant.whiteColor),
            //   child: Text('data',style: appStyle(12),),
            // ),
            color: data.color,
            titleStyle: appStyle(14),
            value: progressPercentage,
            title: data.value.toString(), // No title on the section itself
            radius: widget.chartRadius * 0.3,
          ),
          // The background/remaining section
          PieChartSectionData(
            color: Colors.grey.shade300,
            value: 100 - progressPercentage,
            title: '',
            radius: widget.chartRadius * 0.3,
          ),
        ],
        // Center text display
        // centerSpaceWidget: Text(
        //   '${data.value.toStringAsFixed(0)}%',
        //   style: TextStyle(
        //     fontSize: widget.chartRadius * 0.4,
        //     fontWeight: FontWeight.bold,
        //     color: data.color,
        //   ),
        // ),
      ),
    );
  }

  /// Builds a Bar Chart.
  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY:
            widget.barData!
                .map((data) => data.y)
                .reduce((a, b) => a > b ? a : b) *
            1.2, // Find max Y and add 20% padding
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            // tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final data = widget.barData![groupIndex];
              return BarTooltipItem(
                '${data.label}\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: rod.toY.toString(),
                    style: const TextStyle(color: Colors.yellow),
                  ),
                ],
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                final index = value.toInt();
                if (index >= 0 && index < widget.barData!.length) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      widget.barData![index].label,
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                }
                return const Text('');
              },
              reservedSize: 38,
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: widget.barData!
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: data.color,
                    width: 16,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
        gridData: const FlGridData(show: false),
      ),
    );
  }

  /// Builds the legend/indicator section below the chart.
  Widget _buildLegend() {
    switch (widget.chartType) {
      case ChartType.pie:
        return Wrap(
          // Use Wrap to handle multiple items gracefully
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: widget.pieData!
              .map(
                (data) => _buildIndicator(color: data.color, text: data.name),
              )
              .toList(),
        );
      case ChartType.circularGrowth:
        return _buildIndicator(
          color: widget.growthData!.color,
          text: widget.growthData!.title,
        );
      case ChartType.bar:
        return const SizedBox.shrink();
    }
  }

  /// Helper widget for a single legend item.
  Widget _buildIndicator({required Color color, required String text}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
