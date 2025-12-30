import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/common/common_widget/no_data_found.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';
import 'package:partner_dashboard_web_app/model/common/result.dart';

import '../../../common/app_font/app_font.dart';
import '../../../common/common_methods/common_methods.dart';
import '../../../common/common_methods/responsive.dart';
import '../../../common/theme/color_constant.dart';

class DashboardDataWidget extends StatelessWidget {
  final DashBoardController controller;
  const DashboardDataWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: context.height * 0.8,
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

        child:controller.partnerMoviesList.isNotEmpty? ListView.builder(
          itemCount: controller.partnerMoviesList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Results data = controller.partnerMoviesList[index];
            return DataWidget(
              data: data,
              onTap: () {
                controller.onTapItem(context, data.id.toString());
              },
              index: index,
              hoverIndex: controller.hoverIndex,
              backgroundColor: controller.backGroundColor,
              onEnter: (v) {
                controller.onEnter(v, index);
              },
              onExit: (v) {
                controller.onExit(v, index);
              },
            );
          },
        ):NotDataFound(),
      ),
    );
  }
}

class DataWidget extends StatelessWidget {
  final Results data;
  final Color? backgroundColor;
  final int? hoverIndex;
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
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        hitTestBehavior: HitTestBehavior.opaque,
        onEnter: onEnter,
        onExit: onExit,
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          duration: const Duration(milliseconds: 200), // Smooth transition
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: hoverIndex == index ? Colors.transparent : backgroundColor,
          ),

          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  data.title ?? '',
                  style: appStyle(
                    responsive(context, 12, desktop: 16, tablet: 16),
                    color: ColorConstant.whiteColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  data.movieDuration ?? '',
                  style: appStyle(
                    responsive(context, 12, desktop: 14, tablet: 12),
                    color: ColorConstant.whiteColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                    data.totalWatchMinutes != 0?
                  formatMinutesIntoHours(data.totalWatchMinutes.toString()):'0 h',
                  style: appStyle(
                    responsive(context, 12, desktop: 14, tablet: 12),
                    color: ColorConstant.whiteColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  '${data.totalWatchMinutes.toString()} m',
                  style: appStyle(
                    responsive(context, 12, desktop: 14, tablet: 12),
                    color: ColorConstant.whiteColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  data.viewCount.toString(),
                  style: appStyle(
                    responsive(context, 12, desktop: 14, tablet: 12),
                    color: ColorConstant.whiteColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
