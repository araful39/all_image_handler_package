import 'dart:io';
import 'dart:typed_data';

import 'package:all_image_handler/src/all_image_controller.dart';
import 'package:all_image_handler/src/all_image_error.dart';
import 'package:all_image_handler/src/all_image_options.dart';
import 'package:all_image_handler/src/all_image_shimmer.dart';
import 'package:all_image_handler/src/all_image_utils.dart';
import 'package:all_image_handler/src/all_image_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A versatile Flutter widget that automatically detects and renders images from
/// various sources (network, asset, file, memory, SVG) with support for caching,
/// shimmer loading, retry, error handling, and hero animation.
class AllImageHandler extends StatefulWidget {
  /// Creates an [AllImageHandler] widget.
  const AllImageHandler({
    super.key,
    this.url,
    this.memoryBytes,
    this.width,
    this.height,
    this.size,
    this.color,
    this.backgroundColor,
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
    this.colorFilter,
    this.onTap,
    this.onLongPress,
    this.enableInteractiveViewer = false,
    this.imageBuilder,
    this.options,
    this.controller,
  });

  /// The URL or path to the image (URL, asset path, or file path).
  final String? url;

  /// The raw bytes of the image, if loading from memory.
  final Uint8List? memoryBytes;

  /// The width of the image.
  final double? width;

  /// The height of the image.
  final double? height;

  /// A shortcut to set both [width] and [height] to the same value.
  final double? size;

  /// The color to apply to the image (e.g., tinting an SVG or an image).
  final Color? color;

  /// The background color of the image container.
  final Color? backgroundColor;

  /// How the image should be inscribed into the box.
  final BoxFit fit;

  /// The border radius of the image.
  final BorderRadius? borderRadius;

  /// The shape of the image container (e.g., [BoxShape.circle]).
  final BoxShape shape;

  /// A widget to display while the image is loading.
  final Widget? placeholder;

  /// A widget to display if the image fails to load.
  final Widget? errorWidget;

  /// An asset path to display as a fallback if the main image fails to load.
  final String? fallbackAsset;

  /// A BlurHash string to display while the image is loading.
  final String? blurHash;

  /// A tag for the [Hero] animation.
  final String? heroTag;

  /// Whether to show a retry button if the image fails to load.
  final bool enableRetry;

  /// Whether to use caching for network images.
  final bool useCache;

  /// The duration of the fade-in animation for network images.
  final Duration fadeInDuration;

  /// The filter quality of the image.
  final FilterQuality filterQuality;

  /// How to align the image within its bounds.
  final Alignment alignment;

  /// A custom widget to use for the retry button.
  final Widget? retryButton;

  /// The width of the memory cache.
  final int? memCacheWidth;

  /// The height of the memory cache.
  final int? memCacheHeight;

  /// HTTP headers for network requests.
  final Map<String, String>? headers;

  /// The base color for the shimmer loading effect.
  final Color? shimmerBaseColor;

  /// The highlight color for the shimmer loading effect.
  final Color? shimmerHighlightColor;

  /// Whether to show the shimmer loading effect (default: true).
  final bool showShimmer;

  /// The border to draw around the image.
  final BoxBorder? border;

  /// The box shadow to draw behind the image.
  final List<BoxShadow>? boxShadow;

  /// The margin around the image.
  final EdgeInsetsGeometry? margin;

  /// The padding inside the image container.
  final EdgeInsetsGeometry? padding;

  /// The opacity of the image (0.0 to 1.0).
  final double opacity;

  /// A color filter to apply to the image.
  final ColorFilter? colorFilter;

  /// Callback when the image is tapped.
  final VoidCallback? onTap;

  /// Callback when the image is long pressed.
  final VoidCallback? onLongPress;

  /// Whether to enable [InteractiveViewer] for zooming and panning (default: false).
  final bool enableInteractiveViewer;

  /// A builder function to wrap or replace the default image widget.
  final Widget Function(BuildContext context, Widget child)? imageBuilder;

  /// A set of options to configure the image handler (optional).
  ///
  /// Properties provided directly to the [AllImage] constructor will take precedence
  /// Properties provided directly to the [AllImageHandler] constructor will take precedence
  /// over those in [options].
  final AllImageOptions? options;

  /// A controller to manually trigger reloads or retries.
  final AllImageController? controller;


  /// Factory constructor for network images.
  factory AllImageHandler.network(
    String url, {
    Key? key,
    double? width,
    double? height,
    double? size,
    Color? color,
    Color? backgroundColor,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    BoxShape shape = BoxShape.rectangle,
    Widget? placeholder,
    Widget? errorWidget,
    String? fallbackAsset,
    String? blurHash,
    String? heroTag,
    bool enableRetry = true,
    bool useCache = true,
    Duration fadeInDuration = const Duration(milliseconds: 250),
    FilterQuality filterQuality = FilterQuality.medium,
    Alignment alignment = Alignment.center,
    Widget? retryButton,
    int? memCacheWidth,
    int? memCacheHeight,
    Map<String, String>? headers,
    Color? shimmerBaseColor,
    Color? shimmerHighlightColor,
    AllImageController? controller,
  }) {
    return AllImageHandler(
      key: key,
      url: url,
      width: width,
      height: height,
      size: size,
      color: color,
      backgroundColor: backgroundColor,
      fit: fit,
      borderRadius: borderRadius,
      shape: shape,
      placeholder: placeholder,
      errorWidget: errorWidget,
      fallbackAsset: fallbackAsset,
      blurHash: blurHash,
      heroTag: heroTag,
      enableRetry: enableRetry,
      useCache: useCache,
      fadeInDuration: fadeInDuration,
      filterQuality: filterQuality,
      alignment: alignment,
      retryButton: retryButton,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      headers: headers,
      shimmerBaseColor: shimmerBaseColor,
      shimmerHighlightColor: shimmerHighlightColor,
      controller: controller,
    );
  }

  /// Factory constructor for asset images.
  factory AllImageHandler.asset(
    String assetPath, {
    Key? key,
    double? width,
    double? height,
    double? size,
    Color? color,
    Color? backgroundColor,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    BoxShape shape = BoxShape.rectangle,
    Widget? placeholder,
    Widget? errorWidget,
    String? fallbackAsset,
    String? blurHash,
    String? heroTag,
    FilterQuality filterQuality = FilterQuality.medium,
    Alignment alignment = Alignment.center,
    int? memCacheWidth,
    int? memCacheHeight,
    Color? shimmerBaseColor,
    Color? shimmerHighlightColor,
    AllImageController? controller,
  }) {
    return AllImageHandler(
      key: key,
      url: assetPath,
      width: width,
      height: height,
      size: size,
      color: color,
      backgroundColor: backgroundColor,
      fit: fit,
      borderRadius: borderRadius,
      shape: shape,
      placeholder: placeholder,
      errorWidget: errorWidget,
      fallbackAsset: fallbackAsset,
      blurHash: blurHash,
      heroTag: heroTag,
      filterQuality: filterQuality,
      alignment: alignment,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      shimmerBaseColor: shimmerBaseColor,
      shimmerHighlightColor: shimmerHighlightColor,
      controller: controller,
    );
  }

  /// Factory constructor for file images.
  factory AllImageHandler.file(
    String filePath, {
    Key? key,
    double? width,
    double? height,
    double? size,
    Color? color,
    Color? backgroundColor,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    BoxShape shape = BoxShape.rectangle,
    Widget? placeholder,
    Widget? errorWidget,
    String? fallbackAsset,
    String? blurHash,
    String? heroTag,
    FilterQuality filterQuality = FilterQuality.medium,
    Alignment alignment = Alignment.center,
    int? memCacheWidth,
    int? memCacheHeight,
    Color? shimmerBaseColor,
    Color? shimmerHighlightColor,
    AllImageController? controller,
  }) {
    return AllImageHandler(
      key: key,
      url: filePath,
      width: width,
      height: height,
      size: size,
      color: color,
      backgroundColor: backgroundColor,
      fit: fit,
      borderRadius: borderRadius,
      shape: shape,
      placeholder: placeholder,
      errorWidget: errorWidget,
      fallbackAsset: fallbackAsset,
      blurHash: blurHash,
      heroTag: heroTag,
      filterQuality: filterQuality,
      alignment: alignment,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      shimmerBaseColor: shimmerBaseColor,
      shimmerHighlightColor: shimmerHighlightColor,
      controller: controller,
    );
  }

  @override
  State<AllImageHandler> createState() => _AllImageHandlerState();
}

class _AllImageHandlerState extends State<AllImageHandler> {
  late AllImageController _controller;

  // Helper getters to merge widget properties, options, and global config
  double? get _width =>
      widget.size ??
      widget.width ??
      widget.options?.width ??
      AllImageConfig.options.width;
  double? get _height =>
      widget.size ??
      widget.height ??
      widget.options?.height ??
      AllImageConfig.options.height;
  BoxFit get _fit => widget.fit != BoxFit.cover
      ? widget.fit
      : (widget.options?.fit ?? AllImageConfig.options.fit);
  BorderRadius? get _borderRadius =>
      widget.borderRadius ??
      widget.options?.borderRadius ??
      AllImageConfig.options.borderRadius;
  BoxShape get _shape => widget.shape != BoxShape.rectangle
      ? widget.shape
      : (widget.options?.shape ?? AllImageConfig.options.shape);
  Color? get _backgroundColor =>
      widget.backgroundColor ??
      widget.options?.backgroundColor ??
      AllImageConfig.options.backgroundColor;
  Color? get _color =>
      widget.color ?? widget.options?.color ?? AllImageConfig.options.color;
  String? get _heroTag =>
      widget.heroTag ?? widget.options?.heroTag ?? AllImageConfig.options.heroTag;
  Alignment get _alignment => widget.alignment != Alignment.center
      ? widget.alignment
      : (widget.options?.alignment ?? AllImageConfig.options.alignment);
  Widget? get _placeholder =>
      widget.placeholder ??
      widget.options?.placeholder ??
      AllImageConfig.options.placeholder;
  String? get _blurHash =>
      widget.blurHash ??
      widget.options?.blurHash ??
      AllImageConfig.options.blurHash;
  String? get _fallbackAsset =>
      widget.fallbackAsset ??
      widget.options?.fallbackAsset ??
      AllImageConfig.options.fallbackAsset;
  Widget? get _errorWidget =>
      widget.errorWidget ??
      widget.options?.errorWidget ??
      AllImageConfig.options.errorWidget;
  bool get _enableRetry =>
      widget.enableRetry || (widget.options?.enableRetry ?? AllImageConfig.options.enableRetry);
  Widget? get _retryButton =>
      widget.retryButton ??
      widget.options?.retryButton ??
      AllImageConfig.options.retryButton;
  bool get _useCache =>
      widget.useCache && (widget.options?.useCache ?? AllImageConfig.options.useCache);
  Duration get _fadeInDuration =>
      widget.fadeInDuration != const Duration(milliseconds: 250)
          ? widget.fadeInDuration
          : (widget.options?.fadeInDuration ?? AllImageConfig.options.fadeInDuration);
  FilterQuality get _filterQuality =>
      widget.filterQuality != FilterQuality.medium
          ? widget.filterQuality
          : (widget.options?.filterQuality ?? AllImageConfig.options.filterQuality);
  int? get _memCacheWidth =>
      widget.memCacheWidth ??
      widget.options?.memCacheWidth ??
      AllImageConfig.options.memCacheWidth;
  int? get _memCacheHeight =>
      widget.memCacheHeight ??
      widget.options?.memCacheHeight ??
      AllImageConfig.options.memCacheHeight;
  Map<String, String>? get _headers =>
      widget.headers ?? widget.options?.headers ?? AllImageConfig.options.headers;
  Color? get _shimmerBaseColor =>
      widget.shimmerBaseColor ??
      widget.options?.shimmerBaseColor ??
      AllImageConfig.options.shimmerBaseColor;
  Color? get _shimmerHighlightColor =>
      widget.shimmerHighlightColor ??
      widget.options?.shimmerHighlightColor ??
      AllImageConfig.options.shimmerHighlightColor;
  bool get _showShimmer =>
      widget.showShimmer &&
      (widget.options?.showShimmer ?? AllImageConfig.options.showShimmer);
  BoxBorder? get _border =>
      widget.border ?? widget.options?.border ?? AllImageConfig.options.border;
  List<BoxShadow>? get _boxShadow =>
      widget.boxShadow ??
      widget.options?.boxShadow ??
      AllImageConfig.options.boxShadow;
  EdgeInsetsGeometry? get _margin =>
      widget.margin ?? widget.options?.margin ?? AllImageConfig.options.margin;
  EdgeInsetsGeometry? get _padding =>
      widget.padding ?? widget.options?.padding ?? AllImageConfig.options.padding;
  double get _opacity => widget.opacity != 1.0
      ? widget.opacity
      : (widget.options?.opacity ?? AllImageConfig.options.opacity);
  ColorFilter? get _colorFilter =>
      widget.colorFilter ??
      widget.options?.colorFilter ??
      AllImageConfig.options.colorFilter;
  VoidCallback? get _onTap =>
      widget.onTap ?? widget.options?.onTap ?? AllImageConfig.options.onTap;
  VoidCallback? get _onLongPress =>
      widget.onLongPress ??
      widget.options?.onLongPress ??
      AllImageConfig.options.onLongPress;
  bool get _enableInteractiveViewer =>
      widget.enableInteractiveViewer ||
      (widget.options?.enableInteractiveViewer ??
          AllImageConfig.options.enableInteractiveViewer);
  Widget Function(BuildContext context, Widget child)? get _imageBuilder =>
      widget.imageBuilder ??
      widget.options?.imageBuilder ??
      AllImageConfig.options.imageBuilder;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AllImageController();
    _controller.addListener(_onReload);
  }

  @override
  void didUpdateWidget(covariant AllImageHandler oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onReload);
      if (widget.controller != null) {
        _controller.removeListener(_onReload);
        _controller = widget.controller!;
        _controller.addListener(_onReload);
      }
    }
  }

  void _onReload() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_onReload);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _buildImage();

    if (_colorFilter != null) {
      child = ColorFiltered(colorFilter: _colorFilter!, child: child);
    }

    if (_opacity < 1.0) {
      child = Opacity(opacity: _opacity, child: child);
    }

    if (_padding != null) {
      child = Padding(padding: _padding!, child: child);
    }

    if (_backgroundColor != null ||
        _border != null ||
        _boxShadow != null ||
        _borderRadius != null ||
        _shape == BoxShape.circle) {
      child = Container(
        decoration: BoxDecoration(
          color: _backgroundColor,
          border: _border,
          boxShadow: _boxShadow,
          borderRadius: _shape == BoxShape.circle ? null : _borderRadius,
          shape: _shape,
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      );
    }

    if (_heroTag != null) {
      child = Hero(tag: _heroTag!, child: child);
    }

    if (_imageBuilder != null) {
      child = _imageBuilder!(context, child);
    }

    if (_enableInteractiveViewer) {
      child = InteractiveViewer(child: child);
    }

    if (_onTap != null || _onLongPress != null) {
      child = GestureDetector(
        onTap: _onTap,
        onLongPress: _onLongPress,
        child: child,
      );
    }

    if (_margin != null) {
      child = Padding(padding: _margin!, child: child);
    }

    return child;
  }

  Widget _buildImage() {
    if (widget.memoryBytes != null) {
      return _buildMemory();
    }

    if (AllImageUtils.isNetwork(widget.url)) {
      return _buildNetwork();
    }

    if (AllImageUtils.isFile(widget.url)) {
      return _buildFile();
    }

    return _buildAsset();
  }

  Widget _buildNetwork() {
    final url = widget.url;
    if (url == null || url.trim().isEmpty) return _buildError();

    if (AllImageUtils.isSvg(url)) {
      return SvgPicture.network(
        url,
        key: ValueKey('${url}_${_controller.reloadKey}'),
        width: _width,
        height: _height,
        fit: _fit,
        alignment: _alignment,
        headers: _headers,
        colorFilter:
            _color != null ? ColorFilter.mode(_color!, BlendMode.srcIn) : null,
        placeholderBuilder: (_) => _buildPlaceholder(),
      );
    }

    if (!_useCache) {
      return Image.network(
        url,
        key: ValueKey('${url}_${_controller.reloadKey}'),
        width: _width,
        height: _height,
        fit: _fit,
        alignment: _alignment,
        color: _color,
        headers: _headers,
        filterQuality: _filterQuality,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded || frame != null) return child;
          return _buildPlaceholder();
        },
        errorBuilder: (context, error, stackTrace) => _buildError(),
      );
    }

    return CachedNetworkImage(
      key: ValueKey('${url}_${_controller.reloadKey}'),
      imageUrl: url,
      width: _width,
      height: _height,
      fit: _fit,
      color: _color,
      httpHeaders: _headers,
      memCacheWidth: _memCacheWidth,
      memCacheHeight: _memCacheHeight,
      fadeInDuration: _fadeInDuration,
      placeholder: (context, url) => _buildPlaceholder(),
      errorWidget: (context, url, error) => _buildError(),
    );
  }

  Widget _buildAsset() {
    final url = widget.url ?? _fallbackAsset;
    if (url == null || url.trim().isEmpty) return _buildError();

    if (AllImageUtils.isSvg(url)) {
      return SvgPicture.asset(
        url,
        key: ValueKey('${url}_${_controller.reloadKey}'),
        width: _width,
        height: _height,
        fit: _fit,
        alignment: _alignment,
        colorFilter:
            _color != null ? ColorFilter.mode(_color!, BlendMode.srcIn) : null,
        placeholderBuilder: (_) => _buildPlaceholder(),
      );
    }

    return Image.asset(
      url,
      key: ValueKey('${url}_${_controller.reloadKey}'),
      width: _width,
      height: _height,
      fit: _fit,
      alignment: _alignment,
      color: _color,
      filterQuality: _filterQuality,
      cacheWidth: _memCacheWidth,
      cacheHeight: _memCacheHeight,
      errorBuilder: (context, error, stackTrace) => _buildError(),
    );
  }

  Widget _buildFile() {
    final url = widget.url;
    if (url == null || url.trim().isEmpty) return _buildError();

    final normalizedPath =
        url.startsWith('file://') ? url.replaceFirst('file://', '') : url;
    final file = File(normalizedPath);

    if (AllImageUtils.isSvg(url)) {
      return SvgPicture.file(
        file,
        key: ValueKey('${url}_${_controller.reloadKey}'),
        width: _width,
        height: _height,
        fit: _fit,
        alignment: _alignment,
        colorFilter:
            _color != null ? ColorFilter.mode(_color!, BlendMode.srcIn) : null,
        placeholderBuilder: (_) => _buildPlaceholder(),
      );
    }

    return Image.file(
      file,
      key: ValueKey('${url}_${_controller.reloadKey}'),
      width: _width,
      height: _height,
      fit: _fit,
      alignment: _alignment,
      color: _color,
      filterQuality: _filterQuality,
      cacheWidth: _memCacheWidth,
      cacheHeight: _memCacheHeight,
      errorBuilder: (context, error, stackTrace) => _buildError(),
    );
  }

  Widget _buildMemory() {
    final bytes = widget.memoryBytes;
    if (bytes == null) return _buildError();

    if (AllImageUtils.isSvg(widget.url)) {
      return SvgPicture.memory(
        bytes,
        key: ValueKey('memory_${_controller.reloadKey}'),
        width: _width,
        height: _height,
        fit: _fit,
        alignment: _alignment,
        colorFilter:
            _color != null ? ColorFilter.mode(_color!, BlendMode.srcIn) : null,
        placeholderBuilder: (_) => _buildPlaceholder(),
      );
    }

    return Image.memory(
      bytes,
      key: ValueKey('memory_${_controller.reloadKey}'),
      width: _width,
      height: _height,
      fit: _fit,
      alignment: _alignment,
      color: _color,
      filterQuality: _filterQuality,
      cacheWidth: _memCacheWidth,
      cacheHeight: _memCacheHeight,
      errorBuilder: (context, error, stackTrace) => _buildError(),
    );
  }

  Widget _buildPlaceholder() {
    if (_placeholder != null) {
      return SizedBox(
        width: _width,
        height: _height,
        child: _placeholder,
      );
    }

    if (_blurHash != null && _blurHash!.trim().isNotEmpty) {
      return SizedBox(
        width: _width,
        height: _height,
        child: BlurHash(
          hash: _blurHash!,
          imageFit: _fit,
        ),
      );
    }

    if (!_showShimmer) {
      return SizedBox(
        width: _width,
        height: _height,
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBaseColor =
        isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final defaultHighlightColor =
        isDark ? Colors.grey.shade700 : Colors.grey.shade100;

    return AllImageShimmer(
      width: _width,
      height: _height,
      borderRadius: _borderRadius,
      shape: _shape,
      baseColor: _shimmerBaseColor ?? defaultBaseColor,
      highlightColor: _shimmerHighlightColor ?? defaultHighlightColor,
    );
  }

  Widget _buildError() {
    if (_fallbackAsset != null && _fallbackAsset!.trim().isNotEmpty) {
      final fallback = _fallbackAsset!;
      if (AllImageUtils.isSvg(fallback)) {
        return SvgPicture.asset(
          fallback,
          width: _width,
          height: _height,
          fit: _fit,
          colorFilter:
              _color != null ? ColorFilter.mode(_color!, BlendMode.srcIn) : null,
        );
      }

      return Image.asset(
        fallback,
        width: _width,
        height: _height,
        fit: _fit,
        color: _color,
      );
    }

    if (_errorWidget != null) {
      return SizedBox(
        width: _width,
        height: _height,
        child: _errorWidget,
      );
    }

    return AllImageError(
      width: _width,
      height: _height,
      showRetry: _enableRetry,
      retryButton: _retryButton,
      onRetry: _enableRetry ? _controller.retry : null,
    );
  }
}
