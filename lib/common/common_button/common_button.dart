
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';

import '../loading_widget/loading_widget.dart';
import '../theme/color_constant.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;
  final RxBool? isLoading;
  const CommonButton({super.key, required this.buttonText, this.onTap, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> GestureDetector(
        onTap:isLoading?.value == true?null: onTap,
        child: Container(
          alignment: Alignment.center,
          height:responsive(context, 50,desktop: 55,tablet: 55),
          width:responsive(context, 150,desktop: 150,tablet: 150),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [ColorConstant.lightBlueGradient, ColorConstant.blueGradient],
            ),
          ),
          child:isLoading?.value ?? false ?LoadingWidget(): Text(
            buttonText,
            style: appStyle(responsive(context, 16,desktop: 18,tablet: 18)) ,
          ),
        ),
      ),
    );
  }
}
