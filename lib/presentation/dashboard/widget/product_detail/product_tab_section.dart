import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';
import '../../../../common/common_methods/common_methods.dart';

class ProductTabSection extends StatelessWidget {
  final DashBoardController controller;
  const ProductTabSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductNameWidget(
            name: controller.partnerMovieDetailData.value.title ?? '',
          ),
          CustomImageView(
            radius: BorderRadius.circular(10),
            url: controller.partnerMovieDetailData.value.thumbnailUrl,
            height: 100,
            width: 100,
            fit: BoxFit.contain,
          ),

          GridView.builder(
            // padding: EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: responsive(context, 1, tablet: 2, desktop: 4),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: isMobile(context) ? 9 / 2 : 2,
            ),
            itemCount: 4, // The number of stat cards you have
            itemBuilder: (context, index) {
              return ProductTabWidget(
                title: index == 0
                    ? 'Total Watch Minutes'
                    : index == 1
                    ? 'Total Watch Hours'
                    : index == 2
                    ? 'Total View Count'
                    : 'Total Content length',
                subTitle: index == 0
                    ? '${controller.partnerMovieDetailData.value.watchMinutes ?? ''} m'
                    : index == 1
                    ? formatMinutesIntoHours(
                        controller.partnerMovieDetailData.value.watchMinutes
                            .toString(),
                      )
                    : index == 2
                    ? controller.partnerMovieDetailData.value.viewCount
                          .toString()
                    : '2h 30m',
              );
            },
          ),
        ],
      ),
    );

    //   Container(
    //   padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
    //   margin: EdgeInsets.only(right: 20, top: 40),
    //   child: Row(
    //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     spacing: 10,
    //
    //     children: [
    //
    //       ProductNameWidget(),
    //       ProductTabWidget(title: 'Total Hours',subTitle: '12',),
    //       ProductTabWidget(title: 'Total Length',subTitle: '12',),
    //       ProductTabWidget(title: 'Total Watch Time',subTitle: '12',),
    //       ProductTabWidget(title: 'Total Watch Hours',subTitle: '12',),
    //     ],
    //   ),
    // );
  }
}

class ProductTabWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const ProductTabWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile(context) ? 40 : 120,
      // padding: isMobile(context)
      //     ? EdgeInsets.symmetric(
      //         horizontal: responsive(context, 10, desktop: 40, tablet: 10),
      //         vertical: responsive(context, 10, desktop: 40, tablet: 10),
      //       )
      //     : null,
      margin: isMobile(context)
          ? null
          : EdgeInsets.symmetric(
              // horizontal: responsive(context, 10, desktop: 20, tablet: 10),
              vertical: responsive(context, 10, desktop: 20, tablet: 10),
            ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorConstant.whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: appStyle(
              responsive(context, 14, desktop: 14, tablet: 12),
              color: ColorConstant.darkColor,
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            subTitle,
            style: appStyle(
              responsive(context, 18, desktop: 18, tablet: 16),
              color: ColorConstant.darkColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class ProductNameWidget extends StatelessWidget {
  final String? name;
  const ProductNameWidget({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return Text(name ?? '', style: appStyle(20));
  }
}
