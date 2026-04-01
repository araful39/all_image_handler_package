import 'package:flutter/material.dart';

class AllImageError extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback? onRetry;
  final bool showRetry;
  final Widget? retryButton;

  const AllImageError({
    super.key,
    this.width,
    this.height,
    this.onRetry,
    this.showRetry = true,
    this.retryButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      color: Colors.grey.shade200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.broken_image_outlined, size: 38),
          const SizedBox(height: 8),
          const Text('Image failed'),
          if (showRetry && onRetry != null) ...[
            const SizedBox(height: 10),
            retryButton ??
                ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ],
      ),
    );
  }
}
