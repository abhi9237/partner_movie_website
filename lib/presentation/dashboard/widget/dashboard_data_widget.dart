import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_methods/common_methods.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';
import 'package:partner_dashboard_web_app/model/common/result.dart';

import '../../../common/common_widget/no_data_found.dart';

class DashboardDataWidget extends StatelessWidget {
  final DashBoardController controller;
  const DashboardDataWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: ColorConstant.surface.withValues(alpha: 0.62),
            border: Border.all(color: ColorConstant.borderMuted),
          ),
          child: controller.partnerMoviesList.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: controller.partnerMoviesList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final Results data = controller.partnerMoviesList[index];
                        return DataWidget(
                          data: data,
                          index: index,
                          hoverIndex: controller.hoverIndex,
                          backgroundColor: controller.backGroundColor,
                          onTap: () {
                            controller.onTapItem(context, data.id.toString());
                          },
                          onEnter: (v) => controller.onEnter(v, index),
                          onExit: (v) => controller.onExit(v, index),
                        );
                      },
                    ),
                  ),
                )
              : const NotDataFound(),
        ),
      ),
    );
  }
}

class DataWidget extends StatelessWidget {
  final Results data;
  final Color? backgroundColor;
  final RxInt? hoverIndex;
  final int? index;
  final VoidCallback? onTap;
  final Function(PointerEnterEvent)? onEnter;
  final Function(PointerExitEvent)? onExit;
  const DataWidget({
    super.key,
    this.backgroundColor,
    this.onEnter,
    this.onExit,
    this.hoverIndex,
    this.index,
    this.onTap,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final bool isHovered = hoverIndex?.value == index;

    return MouseRegion(
      hitTestBehavior: HitTestBehavior.opaque,
      onEnter: onEnter,
      onExit: onExit,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: isHovered
                ? ColorConstant.surfaceElevated.withValues(alpha: 0.95)
                : ColorConstant.surfaceStrong.withValues(alpha: 0.62),
            border: Border.all(
              color: isHovered
                  ? ColorConstant.appColor.withValues(alpha: 0.34)
                  : ColorConstant.borderMuted,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                      color: ColorConstant.appColor.withValues(alpha: 0.12),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: LinearGradient(
                        colors: [
                          ColorConstant.appColor.withValues(alpha: 0.28),
                          ColorConstant.blueGradient.withValues(alpha: 0.22),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index! + 1}',
                      style: appStyle(
                        13,
                        color: ColorConstant.whiteColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    data.title ?? '',
                    style: appStyle(
                      responsive(context, 12, desktop: 15, tablet: 14),
                      color: ColorConstant.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(width: 30,),
              Spacer(),
              Expanded(
                child: _MetricChip(
                  value: data.movieDuration ?? 'N/A',
                  accent: ColorConstant.accentMint,
                ),
              ),
              Expanded(
                child: _MetricChip(
                  value: data.totalWatchMinutes != 0
                      ? formatMinutesIntoHours(data.totalWatchMinutes.toString())
                      : '0 h',
                  accent: ColorConstant.appColor,
                ),
              ),
              Expanded(
                child: _MetricChip(
                  value: '${data.totalWatchMinutes.toString()} m',
                  accent: ColorConstant.lightPinkColor,
                ),
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _MetricChip(
                    value: data.viewCount.toString(),
                    accent: ColorConstant.accentAmber,
                  ),
                  SizedBox(width: 10,),
                  if(!isMobile(context))
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.05),
                      border: Border.all(color: ColorConstant.borderMuted),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: ColorConstant.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  final String value;
  final Color accent;
  const _MetricChip({required this.value, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: accent.withValues(alpha: 0.20)),
        ),
        child: Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: appStyle(
            12,
            color: ColorConstant.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
