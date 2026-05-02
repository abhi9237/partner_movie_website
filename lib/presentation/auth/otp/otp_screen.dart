import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../common/common_methods/responsive.dart';
import '../../../common/theme/color_constant.dart';
import '../../../controller/auth_controller.dart';
import '../login/widget/auth_detail_content.dart';
import 'widget/otp_filled_widget.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Padding(
                padding: EdgeInsets.all(isMobile(context) ? 16 : 24),
                child: GetBuilder<AuthController>(
                  init: AuthController(),
                  builder: (controller) {
                    return LayoutBuilder(
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
                              child: OtpFilledWidget(controller: controller),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
