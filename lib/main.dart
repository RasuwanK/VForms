import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vforms/screens/root.dart';
import 'package:vforms/screens/scan.dart';
import 'package:camera/camera.dart';
import 'package:vforms/utils/ocr.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatefulWidget {
  MyApp({super.key, required this.camera});

  final CameraDescription camera;
  final Ocr ocr = Ocr();

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    widget.ocr.initialize();
  }

  @override
  void dispose() {
    widget.ocr.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VForms: Convert physical forms to digital forms',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4687E1)),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => RootScreen(),
        "/scan": (context) => ScanScreen(camera: widget.camera, ocr: widget.ocr)
      },
    );
  }
}
