import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vforms/screens/onboarding/welcome_screen.dart';
import 'package:vforms/screens/onboarding/login_screen.dart';
import 'package:vforms/screens/root.dart';
import 'package:vforms/screens/scan.dart';
import 'package:camera/camera.dart';
import 'package:flutter_edge_ai/flutter_edge_ai.dart';
import 'package:flutter_edge_ai_litertlm/flutter_edge_ai_litertlm.dart';

void main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`

  WidgetsFlutterBinding.ensureInitialized();

  // Loading env
  await dotenv.load(fileName: ".env");

  await FlutterEdgeAi.initialize(
    // Inference engines — add the ones whose packages you depend on:
    inferenceEngines: const [
      LiteRtLmEngine(),     // flutter_edge_ai_litertlm  — .litertlm models
    ],

    // Common settings:
    // String.fromEnvironment yields '' when the define is absent, and an
    // empty token still sends a bare `Authorization: Bearer` header. Pass
    // null instead so the request goes out unauthenticated.
    huggingFaceToken: dotenv.env['HUGGINGFACE_TOKEN'],
    maxDownloadRetries: 10,
  );

  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

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
      initialRoute: "/onboarding/welcome",
      routes: {
        "/onboarding/welcome": (context) => WelcomeScreen(),
        "/onboarding/login": (context) => LoginScreen(),
        "/app": (context) => RootScreen(),
        "/app/scan": (context) => ScanScreen(camera: widget.camera),
      },
    );
  }
}
