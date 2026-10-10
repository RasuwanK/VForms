import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:vforms/utils/ocr.dart';
import 'package:flutter/foundation.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key, required this.camera, required this.ocr});

  final CameraDescription camera;
  final Ocr ocr;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createStaten
    return _ScanScreenState();
  }
}

class _ScanScreenState extends State<ScanScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late Future<void> _initializeOcrFuture;


  @override
  void initState() {
    super.initState();

    // To display an output
    _controller = CameraController(
      // Get a specific camera
      widget.camera,
      ResolutionPreset.medium
    );

    // Initialize controller
    _initializeControllerFuture = _controller.initialize();

    // Initialize OCR
    _initializeOcrFuture = widget.ocr.initialize();

  }

  @override
  void dispose() {
    // Disposing camera controller
    _controller.dispose();

    // Disposing OCR
    widget.ocr.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text('Scanning Document')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          // If future value is complete
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            // Otherwise show loading indicator
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
        try {
          await _initializeControllerFuture;
          await _initializeOcrFuture;

          // Attempt to take the picture
          final image = await _controller.takePicture();

          final Uint8List imageBytes = await image.readAsBytes();

          if (!context.mounted) return;

          // Display on the new screen
          // TODO: Replace with logic to send the picture to the model
          final letters = await widget.ocr.detect(
              imageBytes
          );

        } catch(e) {
          print(e);
        }
      }, child: const Icon(Icons.camera_alt),),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}