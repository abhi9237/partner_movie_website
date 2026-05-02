import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../app_font/app_font.dart';
import '../common_methods/responsive.dart';
import '../image_constant/image_constant.dart';
import '../theme/color_constant.dart';

class NotDataFound extends StatelessWidget {
  const NotDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConstant.surfaceElevated.withValues(alpha: 0.7),
            ),
            child: CustomImageView(
              imagePath: ImageConstant.noDataFound,
              height: responsive(
                context,
                context.width * 0.34,
                tablet: context.width * 0.18,
                desktop: context.width * 0.14,
              ),
              width: responsive(
                context,
                context.width * 0.34,
                tablet: context.width * 0.18,
                desktop: context.width * 0.14,
              ),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'No results yet',
            style: appStyle(
              18,
              color: ColorConstant.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different search or date range to bring content back into view.',
            textAlign: TextAlign.center,
            style: appStyle(
              14,
              color: ColorConstant.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
