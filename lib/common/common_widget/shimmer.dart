import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/get_utils.dart';

import '../common_methods/responsive.dart';
import '../theme/color_constant.dart';

class ShimmerLoading extends StatelessWidget {
  final bool isProductDetailPage;
  const ShimmerLoading({super.key, this.isProductDetailPage = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: FadeShimmer(
              height: 36,
              width: 240,
              radius: 14,
              highlightColor: ColorConstant.surfaceElevated,
              baseColor: ColorConstant.surface,
            ),
          ),
          const SizedBox(height: 24),
          FadeShimmer(
            height: 160,
            width: context.width,
            radius: 28,
            highlightColor: ColorConstant.surfaceElevated,
            baseColor: ColorConstant.surface,
          ),
          const SizedBox(height: 24),
          if (isProductDetailPage)
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: responsive(context, 1, tablet: 2, desktop: 4),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: isMobile(context) ? 9 / 2 : 2,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return const FadeShimmer(
                  height: 72,
                  width: 200,
                  radius: 20,
                  highlightColor: ColorConstant.surfaceElevated,
                  baseColor: ColorConstant.surface,
                );
              },
            ),
          const SizedBox(height: 24),
          FadeShimmer(
            height: context.height * 0.56,
            width: double.infinity,
            radius: 24,
            highlightColor: ColorConstant.surfaceElevated,
            baseColor: ColorConstant.surface,
          ),
        ],
      ),
    );
  }
}
