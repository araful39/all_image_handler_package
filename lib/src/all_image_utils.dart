class AllImageUtils {
  static bool isNetwork(String? url) {
    if (url == null || url.trim().isEmpty) return false;
    final lower = url.toLowerCase();
    return lower.startsWith('http://') || lower.startsWith('https://');
  }

  static bool isFile(String? url) {
    if (url == null || url.trim().isEmpty) return false;
    return url.startsWith('/') ||
        url.startsWith('file://') ||
        url.contains('/storage/') ||
        url.contains(r'\');
  }

  static bool isSvg(String? url) {
    if (url == null || url.trim().isEmpty) return false;
    return url.toLowerCase().split('?').first.endsWith('.svg');
  }
}
