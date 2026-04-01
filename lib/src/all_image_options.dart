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
  final Alignment alignment;
  final Widget? retryButton;
  final int? memCacheWidth;
  final int? memCacheHeight;

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
    this.alignment = Alignment.center,
    this.retryButton,
    this.memCacheWidth,
    this.memCacheHeight,
  });
}
