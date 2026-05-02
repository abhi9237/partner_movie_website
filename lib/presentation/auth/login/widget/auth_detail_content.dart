import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/image_constant/image_constant.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';

class AuthDetailContent extends StatelessWidget {
  const AuthDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsive(
        context,
        context.height * 0.36,
        desktop: context.height,
        tablet: context.height * 0.52,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        image: DecorationImage(
          image: AssetImage(ImageConstant.authBgImg),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: ColorConstant.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.4, sigmaY: 0.4),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.06),
                  ColorConstant.background.withValues(alpha: 0.72),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Colors.white.withValues(alpha: 0.10),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Text(
                    'Partner dashboard',
                    style: appStyle(
                      12,
                      color: ColorConstant.whiteColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: responsive(context, 10, desktop: 18, tablet: 18),
                ),
                Text(
                  'A clearer home for your streaming insights.',
                  style: appStyle(
                    responsive(context, 18, desktop: 52, tablet: 42),
                    color: ColorConstant.whiteColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: responsive(context, 10, desktop: 18, tablet: 18),
                ),
                Text(
                  'Log in to explore content performance, date filtering, and partner detail views in a workspace designed to feel calm and premium.',
                  style: appStyle(
                    responsive(context, 12, desktop: 18, tablet: 16),
                    color: Colors.white.withValues(alpha: 0.88),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 5,
                  runSpacing: 8,
                  children: const [
                    _FeatureChip(label: 'Fast search'),
                    _FeatureChip(label: 'Date range analytics'),
                    _FeatureChip(label: 'Profile overview'),
                  ],
                ),
                SizedBox(
                  height: responsive(context, 10, desktop: 18, tablet: 18),
                ),
                Text(
                  'Built for partners who want a clean, trustworthy analytics experience.',
                  style: appStyle(
                    12,
                    color: Colors.white.withValues(alpha: 0.88),
                    fontWeight: FontWeight.w600,
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

class _FeatureChip extends StatelessWidget {
  final String label;
  const _FeatureChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: responsive(context, 10, desktop: 18, tablet: 18),
      vertical:responsive(context, 5, desktop: 10, tablet: 10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Text(
        label,
        style: appStyle(
          12,
          color: ColorConstant.whiteColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
