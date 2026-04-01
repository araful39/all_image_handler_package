import 'package:flutter/material.dart';

/// A controller used to manage and reload an [AllImage] widget.
class AllImageController extends ChangeNotifier {
  int _reloadKey = 0;

  /// Returns the current reload key, which is used to force a rebuild of the image.
  int get reloadKey => _reloadKey;

  /// Rebuilds the image by incrementing the reload key.
  void reload() {
    _reloadKey++;
    notifyListeners();
  }

  /// Retries loading the image by triggering a reload.
  void retry() {
    reload();
  }
}
