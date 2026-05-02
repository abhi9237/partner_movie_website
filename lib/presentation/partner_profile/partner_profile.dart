import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/material.dart';

import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';

class ProfileScreen extends StatelessWidget {
  final DashBoardController controller;
  const ProfileScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final phone =
        controller.partnerDetailData.value.results?.firstOrNull?.userPhoneNumber;
    final details = controller.partnerDetailData.value.results?.firstOrNull;

    return Container(
      margin: const EdgeInsets.only(left: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: ColorConstant.surface.withValues(alpha: 0.45),
        border: Border.all(color: ColorConstant.border),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 860),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: LinearGradient(
              colors: [
                ColorConstant.surfaceStrong.withValues(alpha: 0.94),
                ColorConstant.surfaceElevated.withValues(alpha: 0.78),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: ColorConstant.borderMuted),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          ColorConstant.appColor.withValues(alpha: 0.65),
                          ColorConstant.blueGradient.withValues(alpha: 0.5),
                        ],
                      ),
                    ),
                    child: ClipOval(
                      child: CustomImageView(
                        radius: BorderRadius.circular(100),
                        height: 132,
                        width: 132,
                        url: details?.thumbnailUrl ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: ColorConstant.appColor.withValues(alpha: 0.14),
                      border: Border.all(color: ColorConstant.appColor.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      'Verified partner',
                      style: appStyle(
                        12,
                        color: ColorConstant.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 28),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details?.name ?? 'Partner profile',
                      style: appStyle(
                        28,
                        color: ColorConstant.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      details?.description ?? '',
                      style: appStyle(
                        15,
                        color: ColorConstant.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _ProfileChip(
                          label: 'Phone',
                          value: phone?.isNotEmpty == true ? phone! : 'Not shared',
                          accent: ColorConstant.accentMint,
                        ),
                        _ProfileChip(
                          label: 'Active catalog',
                          value: '${controller.partnerMoviesList.length}',
                          accent: ColorConstant.accentAmber,
                        ),
                        _ProfileChip(
                          label: 'Focus',
                          value: 'Content analytics',
                          accent: ColorConstant.lightPinkColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: ColorConstant.surface.withValues(alpha: 0.6),
                        border: Border.all(color: ColorConstant.borderMuted),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About this partner',
                            style: appStyle(
                              14,
                              color: ColorConstant.textSecondary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'This area can later host brand details, partnership notes, or contact insights. For now it keeps the profile visually rich while staying aligned with the current data model.',
                            style: appStyle(
                              14,
                              color: ColorConstant.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileChip extends StatelessWidget {
  final String label;
  final String value;
  final Color accent;

  const _ProfileChip({
    required this.label,
    required this.value,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: accent.withValues(alpha: 0.12),
        border: Border.all(color: accent.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: appStyle(
              11,
              color: ColorConstant.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: appStyle(
              14,
              color: ColorConstant.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
