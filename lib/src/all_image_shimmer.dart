import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AllImageShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final Color? baseColor;
  final Color? highlightColor;

  const AllImageShimmer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBaseColor = baseColor ?? Colors.grey.shade300;
    final effectiveHighlightColor = highlightColor ?? Colors.grey.shade100;

    final child = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: effectiveBaseColor,
        shape: shape,
        borderRadius: shape == BoxShape.circle ? null : borderRadius,
      ),
    );

    return Shimmer.fromColors(
      baseColor: effectiveBaseColor,
      highlightColor: effectiveHighlightColor,
      child: child,
    );
  }
}
