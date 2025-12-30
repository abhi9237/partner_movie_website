import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/presentation/auth/login/widget/auth_detail_content.dart';
import 'package:partner_dashboard_web_app/presentation/auth/login/widget/auth_fileds_widget.dart';
import '../../../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if(!isMobile(context))
            AuthDetailContent(),
            if(!isMobile(context))
              Spacer(),
            AuthFieldsWidget(controller: controller,),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
