import 'package:flutter/material.dart';
import 'package:vforms/components/button.dart';

class InitializeScreen extends StatelessWidget {
  const InitializeScreen({super.key, /* required this.progress, required this.startModelDownload */});

  //final double progress;
  //final bool startModelDownload;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 180,
          height: 180,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF4687E1),
          ),
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 100,
          ),
        ),
        SizedBox(height: 30),
        Text(
          'Everything is setup',
          style: TextStyle(
            color: Color(0xFF4687E1),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
