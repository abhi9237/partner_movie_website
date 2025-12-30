import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:partner_dashboard_web_app/presentation/auth/otp/widget/otp_filled_widget.dart';

import '../../../common/common_methods/responsive.dart';
import '../../../controller/auth_controller.dart';
import '../login/widget/auth_detail_content.dart';

class OtpScreen extends StatelessWidget {

  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return SafeArea(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(!isMobile(context))
                  AuthDetailContent(),
                if(!isMobile(context))
                  Spacer(),
                OtpFilledWidget(controller: controller,),
                Spacer(),

              ],
            ),
          );
        }
      ),
    );
  }
}
