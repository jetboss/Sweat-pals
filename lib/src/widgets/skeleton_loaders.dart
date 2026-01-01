import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Reusable skeleton loader widgets with shimmer effect
class SkeletonLoaders {
  /// Shimmer wrapper that automatically handles dark/light mode
  static Widget shimmerWrap(BuildContext context, {required Widget child}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: child,
    );
  }

  /// Card skeleton for list items
  static Widget cardSkeleton(BuildContext context, {double height = 80}) {
    return shimmerWrap(
      context,
      child: Container(
        height: height,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  /// List of skeleton cards
  static Widget listSkeleton(BuildContext context, {int count = 5, double itemHeight = 80}) {
    return Column(
      children: List.generate(
        count,
        (index) => cardSkeleton(context, height: itemHeight),
      ),
    );
  }

  /// Chart placeholder skeleton
  static Widget chartSkeleton(BuildContext context, {double height = 150}) {
    return shimmerWrap(
      context,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  /// Grid item skeleton for Quick Links style grids
  static Widget gridItemSkeleton(BuildContext context) {
    return shimmerWrap(
      context,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  /// Grid skeleton
  static Widget gridSkeleton(BuildContext context, {int count = 6}) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: List.generate(count, (index) => gridItemSkeleton(context)),
    );
  }

  /// Horizontal photo gallery skeleton
  static Widget gallerySkeleton(BuildContext context, {int count = 4}) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: count,
        itemBuilder: (context, index) => shimmerWrap(
          context,
          child: Container(
            width: 100,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }

  /// Text line skeleton (for titles, descriptions)
  static Widget textSkeleton(BuildContext context, {double width = 200, double height = 16}) {
    return shimmerWrap(
      context,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  /// Circle skeleton (for avatars, icons)
  static Widget circleSkeleton(BuildContext context, {double size = 48}) {
    return shimmerWrap(
      context,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
