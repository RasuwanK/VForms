import 'package:flutter/material.dart';

class InitializeScreen extends StatefulWidget {
  const InitializeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _InitializeScreenState();
}

class _InitializeScreenState extends State<InitializeScreen> {
  int downloadProgress = 0;

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Initializing',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 55,
            color: Color(0xFF4687E1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(child: Column(children: [

      ])),
    );
  }
}
