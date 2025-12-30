import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:partner_dashboard_web_app/common/common_widget/no_data_found.dart';
import 'package:partner_dashboard_web_app/common/common_widget/shimmer.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';

import 'dashboard_data_widget.dart';
import 'dashboard_filter_widget.dart';
import 'dashboard_tab_widget.dart';

class DashboardWidget extends StatelessWidget {
  final DashBoardController controller;
  const DashboardWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: controller.isLoading.value == true && controller.partnerMoviesList.isEmpty
            ? ShimmerLoading()
            : Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: DashboardFilterWidget(controller: controller),
                ),
                DashboardTabWidget(),
                DashboardDataWidget(controller: controller),
                SizedBox(height: 10),
              ],
            ),
      )

    );
  }
}
