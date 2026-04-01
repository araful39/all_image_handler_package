import 'package:all_image_handler/all_image_handler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AllImageController();

    return Scaffold(
      appBar: AppBar(title: const Text('All Image Handler')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AllImage(
            path: 'https://picsum.photos/300/200',
            options: AllImageOptions(
              width: 300,
              height: 180,
              borderRadius: BorderRadius.circular(16),
              heroTag: 'network_1',
            ),
          ),
          const SizedBox(height: 24),
          AllImage(
            path:
                'https://upload.wikimedia.org/wikipedia/commons/0/02/SVG_logo.svg',
            options: AllImageOptions(
              width: 120,
              height: 120,
              blurHash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
            ),
          ),
          const SizedBox(height: 24),
          AllImage(
            path: 'https://wrong-domain.com/demo.jpg',
            controller: controller,
            options: AllImageOptions(
              width: 300,
              height: 180,
              enableRetry: true,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ],
      ),
    );
  }
}
