import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/controller/auth_controller.dart';
import 'package:pinput/pinput.dart';
import '../../../../common/common_button/common_button.dart';
import '../../../../common/common_methods/responsive.dart';
import '../../../../common/theme/color_constant.dart';
import '../../login/widget/auth_detail_content.dart';
import '../../login/widget/auth_header.dart';

class OtpFilledWidget extends StatelessWidget {
  final AuthController controller;
  const OtpFilledWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isMobile(context) ? context.width : context.width * 0.35,
      height: context.height,
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: context.height),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive(context, 20, tablet: 20, desktop: 40),
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: EdgeInsets.symmetric(
                  vertical: responsive(
                    context,
                    0,
                    tablet: context.height * 0.25,
                    desktop: context.height * 0.25,
                  ),
                  horizontal: responsive(
                    context,
                    0,
                    tablet: 0,
                    desktop: context.width * 0.01,
                  ),
                ),

                decoration: BoxDecoration(
                  color: ColorConstant.darkColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 10,
                      offset: const Offset(0, 5),
                      color: isMobile(context)
                          ? Colors.transparent
                          : Colors.blueAccent.withValues(alpha: 0.1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    if (isMobile(context))
                      const Padding(
                        padding: EdgeInsets.only(bottom: 60),
                        child: AuthDetailContent(),
                      ),
                    AuthHeader(
                      headerTitle: 'Otp Verification',
                      headerSubTitle: 'Enter your otp',
                    ),
                    const SizedBox(height: 20),
                    Pinput(
                      controller: controller.otpController.value,
                      length: 6,
                      focusedPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: appStyle(
                          18,
                          color: ColorConstant.whiteColor,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorConstant.appColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: appStyle(
                          18,
                          color: ColorConstant.whiteColor,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorConstant.appColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onCompleted: (v){
                        controller.onTapVerify(context);
                      },
                    ),
                    const SizedBox(height: 60),
                    CommonButton(
                      isLoading: controller.isLoadingOtp,
                      buttonText: 'Verify',
                      onTap: () {
                        controller.onTapVerify(context);
                      },
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      ()=> controller.isTimerActive.value
                          ? RichText(
                              text: TextSpan(
                                text: 'Resend OTP in: ',
                                style: appStyle(
                                  14,
                                  color: ColorConstant.whiteColor,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: controller.timerText
                                        .split(' ')
                                        .last, // e.g., "30s"
                                    style: appStyle(
                                      14,
                                      color: ColorConstant.appColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : RichText(
                              text: TextSpan(
                                text: "Didn't receive code? ",
                                style: appStyle(
                                  14,
                                  color: ColorConstant.whiteColor,
                                ), // Style for the normal text
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Resend OTP',
                                    style: appStyle(
                                      14,
                                      color: ColorConstant.appColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        controller.resendOtp();
                                      },
                                  ),
                                ],
                              ),
                            ),
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
