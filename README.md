# 🖼️ All Image Handler

[![Pub Version](https://img.shields.io/pub/v/all_image_handler)](https://pub.dev/packages/all_image_handler)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

The ultimate Flutter image utility for 2026. **All Image Handler** is a zero-configuration, high-performance widget that automatically detects and renders images from any source. Whether it's a URL, a local asset, a file, or raw memory bytes, this package handles it with ease.

---

## ✨ Features

*   🔍 **Smart Auto-Detection**: One property (`url`) to rule them all. Handles Network, Asset, File, and SVG automatically.
*   🚀 **Performance Optimized**: Built-in caching, memory-aware rendering, and BlurHash support.
*   🌍 **Global Config**: Set app-wide defaults (like borderRadius or shimmer colors) in your `main.dart`.
*   🎨 **Premium Styling**: Direct support for `borderRadius`, `border`, `boxShadow`, `opacity`, `margin`, and `padding`.
*   👆 **Full Interactivity**: Built-in `onTap`, `onLongPress`, and `enableInteractiveViewer` (zoom/pan).
*   🪄 **Modern UI**: Theme-aware shimmers (Light/Dark mode) and smooth Hero transitions.
*   🛠️ **Advanced Control**: Manual reload/retry via `AllImageController`.
*   📦 **SVG Ready**: First-class SVG support with network/asset loading and color tinting.

---

## 🚀 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  all_image_handler: ^0.1.0
```

---

## 🌍 Global Configuration

Standardize your app's look by setting global defaults once.

```dart
void main() {
  AllImageConfig.setGlobalOptions(const AllImageOptions(
    borderRadius: BorderRadius.circular(12),
    showShimmer: true,
    fit: BoxFit.cover,
    fadeInDuration: Duration(milliseconds: 300),
  ));
  
  runApp(const MyApp());
}
```

---

## 🖼️ Usage Examples

### 1. Basic Usage
The handler automatically knows if it's a URL, Asset, or File.

```dart
// Network Image
AllImageHandler(url: 'https://picsum.photos/500/300')

// Local Asset
AllImageHandler(url: 'assets/images/logo.png')

// Local File
AllImageHandler(url: '/path/to/image.jpg')
```

### 2. Styling & Interactivity
Create premium UI elements with minimal code.

```dart
AllImageHandler(
  url: 'https://picsum.photos/400',
  size: 200,
  borderRadius: BorderRadius.circular(24),
  border: Border.all(color: Colors.blue, width: 2),
  boxShadow: [
    BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))
  ],
  onTap: () => print('User clicked the image!'),
  enableInteractiveViewer: true, // Allow zooming and panning
)
```

### 3. Circular Profile & SVGs
Perfect for user avatars and icons.

```dart
// Circular Avatar
AllImageHandler(
  url: 'https://i.pravatar.cc/300',
  size: 80,
  shape: BoxShape.circle,
)

// Tinted SVG Icon
AllImageHandler(
  url: 'assets/icons/settings.svg',
  color: Colors.deepPurple,
  size: 32,
)
```

---

## ⚙️ Property Overview

| Property | Type | Description |
| :--- | :--- | :--- |
| `url` | `String?` | The source (URL, Asset path, or File path). |
| `size` | `double?` | Sets both width and height. |
| `borderRadius` | `BorderRadius?` | Corners rounding (Rectangle shape only). |
| `shape` | `BoxShape` | `rectangle` or `circle`. |
| `fit` | `BoxFit` | How to scale the image. |
| `color` | `Color?` | Apply a tint color to the image/SVG. |
| `enableInteractiveViewer` | `bool` | Enables zoom and pan functionality. |
| `onTap` | `VoidCallback?` | Interaction callback. |
| `blurHash` | `String?` | BlurHash string for smooth loading. |
| `showShimmer` | `bool` | Toggle the shimmer effect. |
| `controller` | `AllImageController?` | Manual reload/retry control. |

---

## 👨‍💻 Author

**Md Araful Islam**  
*Flutter Specialist & Mobile Architect*

🔗 [GitHub](https://github.com/araful39)  
📧 [Email](mailto:rajuslam39@gmail.com)

---

## ⭐ Support
If this package saved you time, please give it a **Star** on GitHub!
