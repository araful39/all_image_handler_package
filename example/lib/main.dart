import 'package:all_image_handler/all_image_handler.dart';
import 'package:flutter/material.dart';

void main() {
  // Set global defaults for all AllImageHandler widgets in the app
  AllImageConfig.setGlobalOptions(AllImageOptions(
    borderRadius: BorderRadius.circular(12),
    fit: BoxFit.cover,
    showShimmer: true,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All Image Handler Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DemoScreen(),
    );
  }
}

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final errorController = AllImageController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Image Handler 🖼️'),
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          _buildHeader('Basic Auto-Detection'),
          _buildInfo('One property (url) handles everything automatically.'),
          const SizedBox(height: 12),
          AllImageHandler(
            url: 'https://picsum.photos/600/400',
            height: 200,
            borderRadius: BorderRadius.circular(20),
          ),
          const SizedBox(height: 24),

          _buildHeader('Circular & SVGs'),
          _buildInfo('Perfect for profiles and vector icons.'),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AllImageHandler(
                url: 'https://i.pravatar.cc/300?img=12',
                size: 80,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.deepPurple, width: 2),
              ),
              AllImageHandler(
                url: 'https://upload.wikimedia.org/wikipedia/commons/0/02/SVG_logo.svg',
                size: 80,
                color: Colors.blue, // Tints the SVG
              ),
              const Column(
                children: [
                  AllImageHandler(
                    url: 'assets/icons/home.svg', // Assumed asset
                    size: 40,
                    color: Colors.green,
                  ),
                  Text('Local SVG', style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildHeader('Premium Styling'),
          _buildInfo('Borders, shadows, and opacity built-in.'),
          const SizedBox(height: 12),
          AllImageHandler(
            url: 'https://picsum.photos/seed/styling/600/400',
            height: 180,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 12,
                offset: Offset(0, 6),
              )
            ],
            opacity: 0.8,
          ),
          const SizedBox(height: 24),

          _buildHeader('Zoom & Interaction'),
          _buildInfo('Enable interactive zoom or tap callbacks.'),
          const SizedBox(height: 12),
          AllImageHandler(
            url: 'https://picsum.photos/seed/zoom/800/600',
            height: 200,
            enableInteractiveViewer: true,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Image Tapped!')),
              );
            },
            placeholder: const Center(child: CircularProgressIndicator()),
          ),
          const SizedBox(height: 24),

          _buildHeader('Error Handling & Retry'),
          _buildInfo('Smart retry mechanism via controller.'),
          const SizedBox(height: 12),
          AllImageHandler(
            url: 'https://invalid-url-for-demo.com/img.jpg',
            controller: errorController,
            height: 150,
            enableRetry: true,
            backgroundColor: Colors.grey.shade100,
            errorWidget: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.broken_image, size: 40, color: Colors.red),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () => errorController.retry(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          const Center(
            child: Text(
              'Built for 2026 by Araful Islam',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildInfo(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}
