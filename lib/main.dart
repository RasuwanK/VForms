import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vforms/screens/app/preview_screen.dart';
import 'package:vforms/screens/onboarding_screen.dart';
import 'package:vforms/screens/app/root.dart';
import 'package:vforms/screens/app/scan.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'firebase_options.dart';

void main() async {
  // Loading env
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final firstCamera = cameras.first;

  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Loading the LLM

  // Model model = Model();

  // await model.initialize(dotenv.env['HUGGINGFACE_TOKEN']);

  runApp(MyApp(camera: firstCamera, /* model: model */));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.camera, /* required this.model */});

  final CameraDescription camera;
  //final Model model;

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
      initialRoute: "/onboarding",
      routes: {
        "/onboarding": (context) => OnboardingScreen(/* model: widget.model */),
        "/app": (context) => RootScreen(),
        "/app/scan": (context) => ScanScreen(camera: widget.camera),
      },
    );
  }
}
