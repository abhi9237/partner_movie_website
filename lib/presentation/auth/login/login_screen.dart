import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import 'package:partner_dashboard_web_app/presentation/auth/login/widget/auth_detail_content.dart';
import 'package:partner_dashboard_web_app/presentation/auth/login/widget/auth_fileds_widget.dart';
import '../../../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              Color(0xFF122447),
              ColorConstant.background,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -120,
              right: -100,
              child: _Glow(color: ColorConstant.appColor.withValues(alpha: 0.25)),
            ),
            Positioned(
              bottom: -140,
              left: -120,
              child: _Glow(color: ColorConstant.lightPinkColor.withValues(alpha: 0.18)),
            ),
            SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1280),
                  child: Padding(
                    padding: EdgeInsets.all(isMobile(context) ? 16 : 24),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final bool stacked = constraints.maxWidth < 980;
                        return Flex(
                          direction: stacked ? Axis.vertical : Axis.horizontal,
                          children: [
                            if (!stacked)
                              const Expanded(flex: 5, child: AuthDetailContent()),
                            if (!stacked) const SizedBox(width: 22),
                            Expanded(
                              flex: 4,
                              child: AuthFieldsWidget(controller: controller),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  final Color color;
  const _Glow({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 260,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}
