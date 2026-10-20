import 'package:flutter/material.dart';
import 'package:vforms/components/button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              Icons.document_scanner,
              color: Colors.white,
              size: 100,
            ),
          ),
          const SizedBox(height: 100),
          const Text(
            'Welcome',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 55,
              color: Color(0xFF4687E1),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Convert Your Physical Documents to Digital Documents',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF4687E1),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 80),
        ],
      );
  }
}
