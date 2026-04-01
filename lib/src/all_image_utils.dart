class AllImageUtils {
  static bool isNetwork(String? path) {
    if (path == null || path.trim().isEmpty) return false;
    final lower = path.toLowerCase();
    return lower.startsWith('http://') || lower.startsWith('https://');
  }

  static bool isFile(String? path) {
    if (path == null || path.trim().isEmpty) return false;
    return path.startsWith('/') ||
        path.startsWith('file://') ||
        path.contains('/storage/') ||
        path.contains(r'\');
  }

  static bool isSvg(String? path) {
    if (path == null || path.trim().isEmpty) return false;
    return path.toLowerCase().split('?').first.endsWith('.svg');
  }
}
