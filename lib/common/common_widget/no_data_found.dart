import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/image_constant/image_constant.dart';

class NotDataFound extends StatelessWidget {
  const NotDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.noDataFound,
          height: responsive(
            context,
            context.width * 0.4,
            tablet: context.width * 0.2,
            desktop: context.width * 0.2,
          ),
          width: context.width ,
          fit: BoxFit.contain,
        ),
        Text('No Data Found', style: appStyle(16)),
      ],
    );
  }
}
