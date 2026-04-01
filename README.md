# all_image_handler

A smart Flutter image handler package that automatically detects image sources (network, asset, file, memory) and displays them with advanced features like caching, shimmer loading, retry support, and hero animations.

---

## ✨ Features

* 🔍 Automatic image source detection (Network / Asset / File / Memory)
* ⚡ Fast loading with caching support
* ✨ Shimmer loading effect
* 🔁 Retry button on load failure
* 🧱 Custom error widget support
* 🦸 Hero animation support
* 🎯 Clean and simple API
* 📱 Works on Android, iOS, Web, Windows, macOS, Linux

---

## 🚀 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  all_image_handler: ^0.0.1
```

Then run:

```bash
flutter pub get
```

---

## 📦 Import

```dart
import 'package:all_image_handler/all_image_handler.dart';
```

---

## 🖼️ Basic Usage

```dart
AllImage(
  image: 'https://example.com/image.jpg',
)
```

---

## 🧠 Auto Detection

No need to specify image type 👇

```dart
AllImage(image: 'https://example.com/image.jpg'); // Network
AllImage(image: 'assets/images/logo.png'); // Asset
AllImage(image: file.path); // File
AllImage(image: memoryBytes); // Memory
```

---

## 🎨 Advanced Usage

```dart
AllImage(
  image: 'https://example.com/image.jpg',
  width: 200,
  height: 200,
  fit: BoxFit.cover,

  showShimmer: true,
  enableCache: true,

  heroTag: 'imageHero',

  errorWidget: Icon(Icons.error),
)
```

---

## 🔁 Retry on Error

```dart
AllImage(
  image: 'https://wrong-url.com/image.jpg',
  showRetry: true,
)
```

---

## ✨ Shimmer Loading

```dart
AllImage(
  image: 'https://example.com/image.jpg',
  showShimmer: true,
)
```

---

## 🦸 Hero Animation

```dart
AllImage(
  image: 'https://example.com/image.jpg',
  heroTag: 'myImage',
)
```

---

## ⚙️ Options Overview

| Property    | Type    | Description                       |
| ----------- | ------- | --------------------------------- |
| image       | dynamic | Image source (auto-detected)      |
| width       | double  | Width of image                    |
| height      | double  | Height of image                   |
| fit         | BoxFit  | Image fit                         |
| showShimmer | bool    | Show shimmer while loading        |
| enableCache | bool    | Enable caching for network images |
| showRetry   | bool    | Show retry button on error        |
| errorWidget | Widget  | Custom error widget               |
| heroTag     | String  | Enable hero animation             |

---

## 📸 Screenshots

> ![alt text](image.png)

---

## 🧪 Example

Check the `/example` folder for a complete working demo.

---

## 🤝 Contributing

Contributions are welcome!
Feel free to open issues or submit pull requests.

---

## 📄 License

This project is licensed under the MIT License.

---

## 👨‍💻 Author

**Md Araful Islam**  
Flutter Developer with 2+ years of experience in building scalable mobile applications, real-time features, and production-ready apps for App Store & Play Store.

🔗 LinkedIn: https://linkedin.com/in/your-profile
📧 Email: rajuslam39@gmail.com  
🌐 Portfolio: https://araful39.netlify.app/  
💻 GitHub: https://github.com/araful39  

---


## ⭐ Support

If you like this package, please ⭐ star the repo and share it with others!

---
