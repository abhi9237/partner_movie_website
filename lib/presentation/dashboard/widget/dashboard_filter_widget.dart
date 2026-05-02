import 'package:flutter/material.dart';

import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';

class DashboardFilterWidget extends StatelessWidget {
  final DashBoardController controller;
  const DashboardFilterWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isCompact = isMobile(context) || isTablet(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            ColorConstant.surfaceStrong.withValues(alpha: 0.88),
            ColorConstant.surfaceElevated.withValues(alpha: 0.74),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: ColorConstant.borderMuted),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: appStyle(
                        responsive(context, 28, desktop: 34, tablet: 30),
                        color: ColorConstant.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'A clean snapshot of your partner catalogue and watch activity.',
                      style: appStyle(
                        responsive(context, 14, desktop: 15, tablet: 14),
                        color: ColorConstant.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isCompact)
                _FilterPill(
                  icon: Icons.play_circle_outline_rounded,
                  title: '${controller.partnerMoviesList.length}',
                  subtitle: 'Videos',
                  accent: ColorConstant.accentMint,
                ),
              if (!isCompact) const SizedBox(width: 12),
              if (!isCompact)
                _FilterPill(
                  icon: Icons.schedule_rounded,
                  title: controller.dateRangeText == 'Select Date'
                      ? 'All time'
                      : controller.dateRangeText,
                  subtitle: 'Date range',
                  accent: ColorConstant.accentAmber,
                  maxWidth: 240,
                ),
            ],
          ),
          const SizedBox(height: 18),
          if (isCompact)
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _FilterPill(
                  icon: Icons.play_circle_outline_rounded,
                  title: '${controller.partnerMoviesList.length}',
                  subtitle: 'Videos',
                  accent: ColorConstant.accentMint,
                ),
                _FilterPill(
                  icon: Icons.schedule_rounded,
                  title: controller.dateRangeText == 'Select Date'
                      ? 'All time'
                      : controller.dateRangeText,
                  subtitle: 'Date range',
                  accent: ColorConstant.accentAmber,
                  maxWidth: 240,
                ),
              ],
            ),
          const SizedBox(height: 18),
          isCompact
              ? Column(
                  children: [
                    DashboardCalenderWidget(
                      dateText: controller.dateRangeText,
                      onTap: () {
                        controller.selectDateRange(
                          context,
                          controller.selectedProductId.value,
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    DashboardTextFilledWidget(
                      isShowClearButton: controller.isShowCloseButton.value,
                      controller: controller.searchController.value,
                      onChanged: controller.onChangedTextFilled,
                      onTapClose: controller.onTapCloseTextFilled,
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: DashboardTextFilledWidget(
                        isShowClearButton: controller.isShowCloseButton.value,
                        controller: controller.searchController.value,
                        onChanged: controller.onChangedTextFilled,
                        onTapClose: controller.onTapCloseTextFilled,
                      ),
                    ),
                    const SizedBox(width: 12),
                    DashboardCalenderWidget(
                      dateText: controller.dateRangeText,
                      onTap: () {
                        controller.selectDateRange(
                          context,
                          controller.selectedProductId.value,
                        );
                      },
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final double? maxWidth;

  const _FilterPill({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth ?? 180),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: ColorConstant.surface.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: accent.withValues(alpha: 0.22)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accent.withValues(alpha: 0.14),
              ),
              child: Icon(icon, color: accent, size: 18),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: appStyle(
                      14,
                      color: ColorConstant.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: appStyle(
                      11,
                      color: ColorConstant.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCalenderWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String dateText;
  const DashboardCalenderWidget({
    super.key,
    required this.onTap,
    required this.dateText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        height: 52,
        width: dateText.toLowerCase() == 'select date' ? 160 : 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorConstant.surfaceStrong,
          border: Border.all(color: ColorConstant.borderMuted),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month_rounded, color: ColorConstant.appColor, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                dateText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: appStyle(
                  13,
                  color: ColorConstant.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(Icons.expand_more_rounded, color: ColorConstant.textSecondary),
          ],
        ),
      ),
    );
  }
}

class DashboardTextFilledWidget extends StatelessWidget {
  final VoidCallback onTapClose;
  final Function(String) onChanged;
  final TextEditingController controller;
  final bool isShowClearButton;
  const DashboardTextFilledWidget({
    super.key,
    required this.onTapClose,
    required this.onChanged,
    required this.controller,
    required this.isShowClearButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorConstant.surfaceStrong,
        border: Border.all(color: ColorConstant.borderMuted),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: appStyle(
          14,
          color: ColorConstant.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        cursorColor: ColorConstant.appColor,
        decoration: InputDecoration(
          hintText: 'Search by movie title',
          prefixIcon: const Icon(Icons.search_rounded, color: ColorConstant.textSecondary),
          suffixIcon: isShowClearButton
              ? GestureDetector(
                  onTap: onTapClose,
                  child: const Icon(
                    Icons.close_rounded,
                    color: ColorConstant.textSecondary,
                    size: 18,
                  ),
                )
              : const SizedBox.shrink(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          filled: true,
          fillColor: Colors.transparent,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
