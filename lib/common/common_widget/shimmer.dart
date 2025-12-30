import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/get_utils.dart';

import '../common_methods/responsive.dart';

class ShimmerLoading extends StatelessWidget {
  final bool isProductDetailPage;
  const ShimmerLoading({super.key, this.isProductDetailPage = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const NeverScrollableScrollPhysics(), // Disable scrolling on shimmer
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: FadeShimmer(
              height: 32,
              width: 200,
              radius: 8,
              highlightColor: const Color(0xff222731), // Dark theme highlight
              baseColor: const Color(0xff161a21), // Dark theme base
            ),
          ),
          const SizedBox(height: 30),

          FadeShimmer(
            height: 50,
            width: context.width,
            radius: 20,
            highlightColor: Color(0xff222731),
            baseColor: Color(0xff161a21),
          ),
          const SizedBox(height: 30),
          if (isProductDetailPage == true)
            GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: responsive(context, 1, tablet: 2, desktop: 4),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: isMobile(context) ? 9 / 2 : 2,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return const FadeShimmer(
                  height: 20,
                  width: 200,
                  radius: 20,
                  highlightColor: Color(0xff222731),
                  baseColor: Color(0xff161a21),
                );
              },
            ),
          const SizedBox(height: 30),

          FadeShimmer(
            height: context.height * 0.6,
            width: double.infinity,
            radius: 16,
            highlightColor: Color(0xff222731),
            baseColor: Color(0xff161a21),
          ),
        ],
      ),
    );
  }
}
