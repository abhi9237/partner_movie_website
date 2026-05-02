import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_font/app_font.dart';
import '../common_methods/responsive.dart';
import '../loading_widget/loading_widget.dart';
import '../theme/color_constant.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;
  final RxBool? isLoading;
  const CommonButton({
    super.key,
    required this.buttonText,
    this.onTap,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: isLoading?.value == true ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          height: responsive(context, 52, desktop: 58, tablet: 56),
          width: responsive(context, 170, desktop: 180, tablet: 180),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [ColorConstant.lightBlueGradient, ColorConstant.blueGradient],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: ColorConstant.whiteColor.withValues(alpha: 0.12)),
            boxShadow: [
              BoxShadow(
                blurRadius: 30,
                offset: const Offset(0, 12),
                color: ColorConstant.appColor.withValues(alpha: 0.28),
              ),
            ],
          ),
          child: Center(
            child: isLoading?.value ?? false
                ? const LoadingWidget()
                : Text(
                    buttonText,
                    style: appStyle(
                      responsive(context, 16, desktop: 17, tablet: 17),
                      color: ColorConstant.whiteColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
