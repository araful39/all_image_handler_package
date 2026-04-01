import 'dart:io';
import 'dart:typed_data';

import 'package:all_image_handler/src/all_image_controller.dart';
import 'package:all_image_handler/src/all_image_error.dart';
import 'package:all_image_handler/src/all_image_options.dart';
import 'package:all_image_handler/src/all_image_shimmer.dart';
import 'package:all_image_handler/src/all_image_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllImage extends StatefulWidget {
  final String? path;
  final Uint8List? memoryBytes;
  final AllImageOptions options;
  final AllImageController? controller;

  const AllImage({
    super.key,
    this.path,
    this.memoryBytes,
    this.options = const AllImageOptions(),
    this.controller,
  });

  @override
  State<AllImage> createState() => _AllImageState();
}

class _AllImageState extends State<AllImage> {
  late AllImageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AllImageController();
    _controller.addListener(_onReload);
  }

  @override
  void didUpdateWidget(covariant AllImage oldWidget) {
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

    if (widget.options.backgroundColor != null) {
      child = Container(color: widget.options.backgroundColor, child: child);
    }

    if (widget.options.shape == BoxShape.circle) {
      child = ClipOval(child: child);
    } else if (widget.options.borderRadius != null) {
      child = ClipRRect(
        borderRadius: widget.options.borderRadius!,
        child: child,
      );
    }

    if (widget.options.heroTag != null) {
      child = Hero(tag: widget.options.heroTag!, child: child);
    }

    return child;
  }

  Widget _buildImage() {
    if (widget.memoryBytes != null) {
      return _buildMemory();
    }

    if (AllImageUtils.isNetwork(widget.path)) {
      return _buildNetwork();
    }

    if (AllImageUtils.isFile(widget.path)) {
      return _buildFile();
    }

    return _buildAsset();
  }

  Widget _buildNetwork() {
    final path = widget.path;
    if (path == null || path.trim().isEmpty) return _buildError();

    if (AllImageUtils.isSvg(path)) {
      return SvgPicture.network(
        path,
        key: ValueKey('${path}_${_controller.reloadKey}'),
        width: widget.options.width,
        height: widget.options.height,
        fit: widget.options.fit,
        alignment: widget.options.alignment,
        placeholderBuilder: (_) => _buildPlaceholder(),
      );
    }

    if (!widget.options.useCache) {
      return Image.network(
        path,
        key: ValueKey('${path}_${_controller.reloadKey}'),
        width: widget.options.width,
        height: widget.options.height,
        fit: widget.options.fit,
        alignment: widget.options.alignment,
        filterQuality: widget.options.filterQuality,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded || frame != null) return child;
          return _buildPlaceholder();
        },
        errorBuilder: (_, _, _) => _buildError(),
      );
    }

    return CachedNetworkImage(
      key: ValueKey('${path}_${_controller.reloadKey}'),
      imageUrl: path,
      width: widget.options.width,
      height: widget.options.height,
      fit: widget.options.fit,
      memCacheWidth: widget.options.memCacheWidth,
      memCacheHeight: widget.options.memCacheHeight,
      fadeInDuration: widget.options.fadeInDuration,
      placeholder: (_, _) => _buildPlaceholder(),
      errorWidget: (_, _, _) => _buildError(),
    );
  }

  Widget _buildAsset() {
    final path = widget.path;
    if (path == null || path.trim().isEmpty) return _buildError();

    if (AllImageUtils.isSvg(path)) {
      return SvgPicture.asset(
        path,
        key: ValueKey('${path}_${_controller.reloadKey}'),
        width: widget.options.width,
        height: widget.options.height,
        fit: widget.options.fit,
        alignment: widget.options.alignment,
        placeholderBuilder: (_) => _buildPlaceholder(),
      );
    }

    return Image.asset(
      path,
      key: ValueKey('${path}_${_controller.reloadKey}'),
      width: widget.options.width,
      height: widget.options.height,
      fit: widget.options.fit,
      alignment: widget.options.alignment,
      filterQuality: widget.options.filterQuality,
      cacheWidth: widget.options.memCacheWidth,
      cacheHeight: widget.options.memCacheHeight,
      errorBuilder: (_, _, _) => _buildError(),
    );
  }

  Widget _buildFile() {
    final path = widget.path;
    if (path == null || path.trim().isEmpty) return _buildError();

    final normalizedPath = path.startsWith('file://')
        ? path.replaceFirst('file://', '')
        : path;
    final file = File(normalizedPath);

    if (AllImageUtils.isSvg(path)) {
      return SvgPicture.file(
        file,
        key: ValueKey('${path}_${_controller.reloadKey}'),
        width: widget.options.width,
        height: widget.options.height,
        fit: widget.options.fit,
        alignment: widget.options.alignment,
        placeholderBuilder: (_) => _buildPlaceholder(),
      );
    }

    return Image.file(
      file,
      key: ValueKey('${path}_${_controller.reloadKey}'),
      width: widget.options.width,
      height: widget.options.height,
      fit: widget.options.fit,
      alignment: widget.options.alignment,
      filterQuality: widget.options.filterQuality,
      cacheWidth: widget.options.memCacheWidth,
      cacheHeight: widget.options.memCacheHeight,
      errorBuilder: (_, _, _) => _buildError(),
    );
  }

  Widget _buildMemory() {
    final bytes = widget.memoryBytes;
    if (bytes == null) return _buildError();

    if (AllImageUtils.isSvg(widget.path)) {
      return SvgPicture.memory(
        bytes,
        key: ValueKey('memory_${_controller.reloadKey}'),
        width: widget.options.width,
        height: widget.options.height,
        fit: widget.options.fit,
        alignment: widget.options.alignment,
        placeholderBuilder: (_) => _buildPlaceholder(),
      );
    }

    return Image.memory(
      bytes,
      key: ValueKey('memory_${_controller.reloadKey}'),
      width: widget.options.width,
      height: widget.options.height,
      fit: widget.options.fit,
      alignment: widget.options.alignment,
      filterQuality: widget.options.filterQuality,
      cacheWidth: widget.options.memCacheWidth,
      cacheHeight: widget.options.memCacheHeight,
      errorBuilder: (_, _, _) => _buildError(),
    );
  }

  Widget _buildPlaceholder() {
    if (widget.options.placeholder != null) {
      return SizedBox(
        width: widget.options.width,
        height: widget.options.height,
        child: widget.options.placeholder,
      );
    }

    if (widget.options.blurHash != null &&
        widget.options.blurHash!.trim().isNotEmpty) {
      return SizedBox(
        width: widget.options.width,
        height: widget.options.height,
        child: BlurHash(
          hash: widget.options.blurHash!,
          imageFit: widget.options.fit,
        ),
      );
    }

    return AllImageShimmer(
      width: widget.options.width,
      height: widget.options.height,
      borderRadius: widget.options.borderRadius,
      shape: widget.options.shape,
    );
  }

  Widget _buildError() {
    if (widget.options.fallbackAsset != null &&
        widget.options.fallbackAsset!.trim().isNotEmpty) {
      final fallback = widget.options.fallbackAsset!;
      if (AllImageUtils.isSvg(fallback)) {
        return SvgPicture.asset(
          fallback,
          width: widget.options.width,
          height: widget.options.height,
          fit: widget.options.fit,
        );
      }

      return Image.asset(
        fallback,
        width: widget.options.width,
        height: widget.options.height,
        fit: widget.options.fit,
      );
    }

    if (widget.options.errorWidget != null) {
      return SizedBox(
        width: widget.options.width,
        height: widget.options.height,
        child: widget.options.errorWidget,
      );
    }

    return AllImageError(
      width: widget.options.width,
      height: widget.options.height,
      showRetry: widget.options.enableRetry,
      retryButton: widget.options.retryButton,
      onRetry: widget.options.enableRetry ? _controller.retry : null,
    );
  }
}
