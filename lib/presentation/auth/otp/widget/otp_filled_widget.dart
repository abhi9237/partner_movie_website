import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_button/common_button.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import 'package:pinput/pinput.dart';

import '../../../../controller/auth_controller.dart';
import '../../login/widget/auth_detail_content.dart';
import '../../login/widget/auth_header.dart';

class OtpFilledWidget extends StatelessWidget {
  final AuthController controller;
  const OtpFilledWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final pinSize = isMobile(context) ? 46.0 : 56.0;
    final pinWidth = isMobile(context) ? 40.0 : 56.0;

    final defaultPinTheme = PinTheme(
      width: pinWidth,
      height: pinSize,
      textStyle: appStyle(
        18,
        color: ColorConstant.whiteColor,
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.surfaceStrong,
        border: Border.all(color: ColorConstant.borderMuted),
        borderRadius: BorderRadius.circular(16),
      ),
    );

    return Container(
      constraints: const BoxConstraints(maxWidth: 560),
      padding: EdgeInsets.all(isMobile(context) ? 18 : 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: LinearGradient(
          colors: [
            ColorConstant.surfaceStrong.withValues(alpha: 0.96),
            ColorConstant.surfaceElevated.withValues(alpha: 0.88),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: ColorConstant.borderMuted),
        boxShadow: [
          BoxShadow(
            blurRadius: 34,
            offset: const Offset(0, 18),
            color: Colors.black.withValues(alpha: 0.22),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: isMobile(context) ? 0 : context.height * 0.86),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isMobile(context)) ...[
                  const AuthDetailContent(),
                  const SizedBox(height: 20),
                ],
                const AuthHeader(
                  headerTitle: 'OTP verification',
                  headerSubTitle: 'Enter the 6 digit code sent to your number',
                ),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: ColorConstant.surface.withValues(alpha: 0.65),
                    border: Border.all(color: ColorConstant.borderMuted),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Verification code',
                        style: appStyle(
                          12,
                          color: ColorConstant.textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Pinput(
                          controller: controller.otpController.value,
                          length: 6,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              border: Border.all(color: ColorConstant.appColor),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 14,
                                  color: ColorConstant.appColor.withValues(alpha: 0.22),
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              border: Border.all(color: ColorConstant.appColor),
                            ),
                          ),
                          separatorBuilder: (_) => const SizedBox(width: 8),
                          onCompleted: (_) => controller.onTapVerify(context),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                CommonButton(
                  isLoading: controller.isLoadingOtp,
                  buttonText: 'Verify',
                  onTap: () {
                    controller.onTapVerify(context);
                  },
                ),
                const SizedBox(height: 20),
                Obx(
                  () => Center(
                    child: controller.isTimerActive.value
                        ? RichText(
                            text: TextSpan(
                              text: 'Resend OTP in: ',
                              style: appStyle(
                                14,
                                color: ColorConstant.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: controller.timerText.split(' ').last,
                                  style: appStyle(
                                    14,
                                    color: ColorConstant.appColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "Didn't receive code? ",
                                style: appStyle(
                                  14,
                                  color: ColorConstant.textSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextButton(
                                onPressed: controller.resendOtp,
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Resend OTP',
                                  style: appStyle(
                                    14,
                                    color: ColorConstant.appColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
