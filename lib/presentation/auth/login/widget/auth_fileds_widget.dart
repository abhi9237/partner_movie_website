import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_button/common_button.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import '../../../../controller/auth_controller.dart';
import 'auth_detail_content.dart';
import 'auth_header.dart';
import 'auth_textField.dart';

class AuthFieldsWidget extends StatelessWidget {
  final AuthController controller;
  const AuthFieldsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 6),
                const AuthHeader(
                  headerTitle: 'Welcome back',
                  headerSubTitle: 'Login as partner to continue',
                ),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: ColorConstant.surface.withValues(alpha: 0.65),
                    border: Border.all(color: ColorConstant.borderMuted),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Mobile number',
                        style: appStyle(
                          12,
                          color: ColorConstant.textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      AuthTextField(
                        onTapPrefixIcon: () {},
                        textEditingController: controller.mobileController.value,
                        onChanged: controller.onTapSelectCountry,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                CommonButton(
                  isLoading: controller.isLoading,
                  buttonText: 'Login',
                  onTap: () {
                    controller.onTapLogin(context);
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'We will send a one-time password to verify your partner account.',
                  textAlign: TextAlign.center,
                  style: appStyle(
                    13,
                    color: ColorConstant.textSecondary,
                    fontWeight: FontWeight.w500,
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
