import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
      ResolutionPreset.medium
    );

    // Initialize controller
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
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

          // Attempt to take the picture
          final image = await _controller.takePicture();

          if (!context.mounted) return;

          // Display on the new screen
          // TODO: Replace with logic to send the picture to the model
          await Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => DisplayPictureScreen(
                imagePath: image.path
              )
            )
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