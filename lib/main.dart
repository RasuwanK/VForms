import 'package:flutter/material.dart';
import 'package:vforms/screens/root.dart';
import 'package:vforms/screens/forms.dart';
import 'package:vforms/screens/scan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VForms: Convert physical forms to digital forms',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4687E1)),
        useMaterial3: true,
      ),
      home: RootPage(),
      //home: const HomePage(),
    );
  }
}
