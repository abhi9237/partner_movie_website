import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import material for BoxConstraints
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import '../../../../common/common_button/common_button.dart';
import '../../../../common/common_methods/responsive.dart';
import '../../../../controller/auth_controller.dart';
import 'auth_detail_content.dart';
import 'auth_header.dart';
import 'auth_textField.dart';

class AuthFieldsWidget extends StatelessWidget {
  final AuthController controller;
  const AuthFieldsWidget({super.key, required this.controller});

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
                       headerTitle: 'Welcome',
                       headerSubTitle: 'Login as Partner',
                     ),
                    const SizedBox(height: 20),
                    AuthTextField(
                      onTapPrefixIcon: () {},
                      textEditingController: controller.mobileController.value,
                      onChanged:controller.onTapSelectCountry ,
                    ),
                    const SizedBox(height: 60),
                    CommonButton(
                      isLoading: controller.isLoading,
                      buttonText: 'Login',
                      onTap: () {
                        controller.onTapLogin(context);
                      },
                    ),
                    SizedBox(height: 60),
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
