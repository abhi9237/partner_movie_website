import 'dart:ui';

import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/material.dart';

import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_widget/common_widget.dart';
import 'package:partner_dashboard_web_app/common/image_constant/image_constant.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';

class DrawerWidget extends StatelessWidget {
  final DashBoardController controller;
  const DrawerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      margin: const EdgeInsets.fromLTRB(24, 24, 0, 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                colors: [
                  ColorConstant.surfaceElevated.withValues(alpha: 0.84),
                  ColorConstant.surfaceStrong.withValues(alpha: 0.94),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: ColorConstant.border),
              boxShadow: [
                BoxShadow(
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                  color: Colors.black.withValues(alpha: 0.26),
                ),
              ],
            ),
            child: Column(
              children: [
                _BrandHeader(),
                const SizedBox(height: 18),
                _StatusCard(controller: controller),
                const SizedBox(height: 22),
                Expanded(
                  child: Column(
                    children: [
                      _NavigationItem(
                        icon: Icons.space_dashboard_rounded,
                        label: 'Dashboard',
                        selected: controller.selectedDrawerIndex.value == 0,
                        onTap: () => controller.onTapSelectDrawer(0),
                      ),
                      const SizedBox(height: 12),
                      _NavigationItem(
                        icon: Icons.person_rounded,
                        label: 'Profile',
                        selected: controller.selectedDrawerIndex.value == 1,
                        onTap: () {
                          controller.onTapSelectDrawer(1);
                          controller.getPartnerDetail();
                        },
                      ),
                      const Spacer(),
                      _LogoutItem(
                        onTap: () => showLogoutPopup(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            ColorConstant.appColor.withValues(alpha: 0.22),
            ColorConstant.blueGradient.withValues(alpha: 0.14),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: ColorConstant.borderMuted),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.oceaniekLogo,
            height: 44,
            width: 170,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 14),
          Text(
            'Partner intelligence',
            style: appStyle(
              20,
              color: ColorConstant.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Track performance, search content, and review analytics in one calm workspace.',
            style: appStyle(
              13,
              color: ColorConstant.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final DashBoardController controller;
  const _StatusCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstant.surface.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: ColorConstant.borderMuted),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Navigation',
            style: appStyle(
              12,
              color: ColorConstant.textMuted,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            controller.selectedDrawerIndex.value == 0 ? 'Content dashboard' : 'Partner profile',
            style: appStyle(
              16,
              color: ColorConstant.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            controller.selectedDrawerIndex.value == 0
                ? 'Search the catalogue, filter by date, and inspect watch performance.'
                : 'Review your partner identity and published details.',
            style: appStyle(
              13,
              color: ColorConstant.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _NavigationItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: selected
              ? LinearGradient(
                  colors: [
                    ColorConstant.appColor.withValues(alpha: 0.28),
                    ColorConstant.blueGradient.withValues(alpha: 0.18),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: selected ? null : ColorConstant.surface.withValues(alpha: 0.45),
          border: Border.all(
            color: selected ? ColorConstant.appColor.withValues(alpha: 0.35) : ColorConstant.borderMuted,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? Colors.white.withValues(alpha: 0.14)
                    : Colors.white.withValues(alpha: 0.05),
              ),
              child: Icon(
                icon,
                size: 20,
                color: selected ? Colors.white : ColorConstant.textSecondary,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: appStyle(
                  15,
                  color: selected ? ColorConstant.whiteColor : ColorConstant.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Icon(
              selected ? Icons.arrow_forward_ios_rounded : Icons.keyboard_arrow_right_rounded,
              size: 16,
              color: selected ? Colors.white : ColorConstant.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoutItem extends StatelessWidget {
  final VoidCallback onTap;
  const _LogoutItem({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.redAccent.withValues(alpha: 0.16),
          border: Border.all(color: Colors.redAccent.withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            const Icon(Icons.logout_rounded, color: Colors.redAccent, size: 20),
            const SizedBox(width: 14),
            Text(
              'Logout',
              style: appStyle(
                15,
                color: Colors.redAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
