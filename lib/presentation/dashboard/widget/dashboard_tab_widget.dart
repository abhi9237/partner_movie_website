import 'package:flutter/material.dart';

import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';

class DashboardTabWidget extends StatelessWidget {
  const DashboardTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: ColorConstant.surfaceStrong.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: ColorConstant.borderMuted),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _HeaderCell(title: 'Product', align: Alignment.centerLeft),
          ),
          Expanded(child: _HeaderCell(title: 'Content length')),
          Expanded(child: _HeaderCell(title: 'Watch hours')),
          Expanded(child: _HeaderCell(title: 'Watch minutes')),
          Expanded(child: _HeaderCell(title: 'Views')),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String title;
  final Alignment align;
  const _HeaderCell({required this.title, this.align = Alignment.center});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: Text(
        title,
        style: appStyle(
          responsive(context, 11, desktop: 12, tablet: 11),
          color: ColorConstant.textSecondary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
