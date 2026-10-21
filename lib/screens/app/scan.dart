import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:vforms/screens/app/preview_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createStaten
    return _ScanScreenState();
  }
}

class _ScanScreenState extends State<ScanScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    // To display an output
    _controller = CameraController(
      // Get a specific camera
      widget.camera,
      ResolutionPreset.medium,
    );

    // Initialize controller
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Disposing camera controller
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          // If future value is complete
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: ClipRect(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final previewSize = _controller.value.previewSize!;

                        return FittedBox(
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: previewSize.height,
                            height: previewSize.width,
                            child: CameraPreview(_controller),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _cameraButton(
                            Icons.close,
                            () => Navigator.pop(context),
                          ),
                          _cameraButton(Icons.flash_off, () {}),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 56, height: 56),
                          GestureDetector(
                            onTap: () {
                              _takePhoto(context);
                            },
                            child: Container(
                              width: 76,
                              height: 76,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Otherwise show loading indicator
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<void> _takePhoto(BuildContext context) async {
    try {
      await _initializeControllerFuture;
      // Take image
      final image = await _controller.takePicture();

      if (!context.mounted) return;

      // Route to the page with photo view
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PreviewScreen(
              imagePath: image.path,
            )
        )
      );
    } catch (e) {
      // Handle error
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occured while taking the photo')),
      );

      debugPrint(e.toString());
    }

    // try {
    //   await _initializeControllerFuture;
    //   final textRecognizer = TextRecognizer(
    //     script: TextRecognitionScript.latin,
    //   );
    //
    //   // Attempt to take the picture
    //   final image = await _controller.takePicture();
    //   final inputImage = InputImage.fromFilePath(image.path);
    //   final RecognizedText recognizedText = await textRecognizer.processImage(
    //     inputImage,
    //   );
    //
    //   String text = recognizedText.text;
    //
    //   for (TextBlock block in recognizedText.blocks) {
    //     final Rect rect = block.boundingBox;
    //     final List<Point<int>> cornerPoints = block.cornerPoints;
    //     final String text = block.text;
    //     final List<String> languages = block.recognizedLanguages;
    //
    //     for (TextLine line in block.lines) {
    //       for (TextElement element in line.elements) {
    //         debugPrint(element.text);
    //       }
    //     }
    //   }
    //
    //   textRecognizer.close();
    // } catch (e) {
    //   print(e);
    // }
  }

  Widget _cameraButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      style: IconButton.styleFrom(
        backgroundColor: Colors.black.withValues(alpha: 0.4),
        fixedSize: const Size(48, 48),
      ),
    );
  }
}

// ElevatedButton(
// style: ElevatedButton.styleFrom(
// shape: const CircleBorder(),
// padding: EdgeInsets.all(30)
// ),
// onPressed: () async {
// try {
// await _initializeControllerFuture;
// final textRecognizer = TextRecognizer(
// script: TextRecognitionScript.latin,
// );
//
// // Attempt to take the picture
// final image = await _controller.takePicture();
// final inputImage = InputImage.fromFilePath(image.path);
// final RecognizedText recognizedText = await textRecognizer
//     .processImage(inputImage);
//
// String text = recognizedText.text;
//
// for (TextBlock block in recognizedText.blocks) {
// final Rect rect = block.boundingBox;
// final List<Point<int>> cornerPoints = block.cornerPoints;
// final String text = block.text;
// final List<String> languages = block.recognizedLanguages;
//
// for (TextLine line in block.lines) {
// for (TextElement element in line.elements) {
// debugPrint(element.text);
// }
// }
// }
//
// textRecognizer.close();
// } catch (e) {
// print(e);
// }
// },
// child: Text('Capture'),
// )
