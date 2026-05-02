import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/material.dart';

import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_methods/common_methods.dart';
import 'package:partner_dashboard_web_app/common/common_methods/responsive.dart';
import 'package:partner_dashboard_web_app/common/theme/color_constant.dart';
import 'package:partner_dashboard_web_app/controller/dashboard_controller.dart';

class ProductTabSection extends StatelessWidget {
  final DashBoardController controller;
  const ProductTabSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final detail = controller.partnerMovieDetailData.value;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: ColorConstant.surface.withValues(alpha: 0.65),
        border: Border.all(color: ColorConstant.borderMuted),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: CustomImageView(
                  url: detail.thumbnailUrl,
                  height: responsive(context, 140, desktop: 160, tablet: 150),
                  width: responsive(context, 110, desktop: 160, tablet: 150),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.title ?? '',
                      style: appStyle(
                        responsive(context, 22, desktop: 28, tablet: 24),
                        color: ColorConstant.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Performance summary for the selected content',
                      style: appStyle(
                        13,
                        color: ColorConstant.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _InfoChip(
                          label: 'Watch Minutes',
                          value: '${detail.watchMinutes ?? 0} m',
                          accent: ColorConstant.appColor,
                        ),
                        _InfoChip(
                          label: 'Watch Hours',
                          value: detail.watchMinutes == 0
                              ? '0 h'
                              : formatMinutesIntoHours(
                                  detail.watchMinutes.toString(),
                                ),
                          accent: ColorConstant.accentMint,
                        ),
                        _InfoChip(
                          label: 'View Count',
                          value: detail.viewCount?.toString() ?? '0',
                          accent: ColorConstant.accentAmber,
                        ),
                        _InfoChip(
                          label: 'Content Length',
                          value: '2h 30m',
                          accent: ColorConstant.lightPinkColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: responsive(context, 1, tablet: 2, desktop: 4),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: isMobile(context) ? 2.7 : 2.3,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return ProductTabWidget(
                title: index == 0
                    ? 'Total Watch Minutes'
                    : index == 1
                        ? 'Total Watch Hours'
                        : index == 2
                            ? 'Total View Count'
                            : 'Total Content Length',
                subTitle: index == 0
                    ? '${detail.watchMinutes ?? 0} m'
                    : index == 1
                        ? detail.watchMinutes == 0
                            ? '0 h'
                            : formatMinutesIntoHours(detail.watchMinutes.toString())
                        : index == 2
                            ? detail.viewCount.toString()
                            : '2h 30m',
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProductTabWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const ProductTabWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: ColorConstant.surfaceStrong.withValues(alpha: 0.85),
        border: Border.all(color: ColorConstant.borderMuted),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: appStyle(
              responsive(context, 12, desktop: 13, tablet: 12),
              color: ColorConstant.textSecondary,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            subTitle,
            style: appStyle(
              responsive(context, 18, desktop: 22, tablet: 18),
              color: ColorConstant.textPrimary,
              fontWeight: FontWeight.w800,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class ProductNameWidget extends StatelessWidget {
  final String? name;
  const ProductNameWidget({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return Text(name ?? '', style: appStyle(20));
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  final Color accent;

  const _InfoChip({
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
          const SizedBox(height: 5),
          Text(
            value,
            style: appStyle(
              15,
              color: ColorConstant.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
