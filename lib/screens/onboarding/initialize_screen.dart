import 'package:flutter/material.dart';
import 'package:vforms/components/button.dart';

class InitializeScreen extends StatelessWidget {
  const InitializeScreen({super.key,required this.progress, required this.startModelDownload});

  final double progress;
  final bool startModelDownload;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Let\'s Download The Models',
          style: TextStyle(
            color: Color(0xFF4687E1),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'To use the app it is required to download the necessary models which will take few moments',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF4687E1)),
        ),
        SizedBox(height: 20),
        if (startModelDownload) LinearProgressIndicator(
          value: progress,
        )
      ],
    );
  }
}
