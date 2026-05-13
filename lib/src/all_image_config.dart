import 'package:all_image_handler/src/all_image_options.dart';

/// Global configuration for [AllImageHandler] widgets.
class AllImageConfig {
  static AllImageOptions _globalOptions = const AllImageOptions();

  /// Returns the current global options.
  static AllImageOptions get options => _globalOptions;

  /// Sets the global options for all [AllImageHandler] widgets.
  /// 
  /// This should typically be called once at the start of the application.
  static void setGlobalOptions(AllImageOptions options) {
    _globalOptions = options;
  }

  /// Resets the global options to their default values.
  static void reset() {
    _globalOptions = const AllImageOptions();
  }
}
