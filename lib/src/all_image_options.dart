import 'package:flutter/material.dart';

class AllImageOptions {
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final Widget? placeholder;
  final Widget? errorWidget;
  final String? fallbackAsset;
  final String? blurHash;
  final String? heroTag;
  final bool enableRetry;
  final bool useCache;
  final Duration fadeInDuration;
  final FilterQuality filterQuality;
  final Color? backgroundColor;
  final Color? color;
  final ColorFilter? colorFilter;
  final Alignment alignment;
  final Widget? retryButton;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final Map<String, String>? headers;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final bool showShimmer;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double opacity;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool enableInteractiveViewer;
  final Widget Function(BuildContext context, Widget child)? imageBuilder;

  const AllImageOptions({
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.placeholder,
    this.errorWidget,
    this.fallbackAsset,
    this.blurHash,
    this.heroTag,
    this.enableRetry = true,
    this.useCache = true,
    this.fadeInDuration = const Duration(milliseconds: 250),
    this.filterQuality = FilterQuality.medium,
    this.backgroundColor,
    this.color,
    this.colorFilter,
    this.alignment = Alignment.center,
    this.retryButton,
    this.memCacheWidth,
    this.memCacheHeight,
    this.headers,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.showShimmer = true,
    this.border,
    this.boxShadow,
    this.margin,
    this.padding,
    this.opacity = 1.0,
    this.onTap,
    this.onLongPress,
    this.enableInteractiveViewer = false,
    this.imageBuilder,
  });
}
