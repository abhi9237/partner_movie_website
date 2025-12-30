import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/image_constant/image_constant.dart';

class AuthDetailContent extends StatelessWidget {
  const AuthDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsive(context, context.height*0.25,desktop: context.height,tablet: context.height),
      width: responsive(context, context.width*0.6,desktop:context.width*0.45,tablet: context.width*0.45) ,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(ImageConstant.authBgImg),fit: BoxFit.cover),
      ),
    );
  }
}
