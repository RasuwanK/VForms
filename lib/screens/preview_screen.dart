import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vforms/utils/ocr.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Image Preview')
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 2
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 30,
            children: [
              Image.file(
                  File(imagePath),
                  height: 600,
                  fit: BoxFit.contain
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () async {
                            await _scanImage();
                          },
                          child: Text('Scan')
                      ),
                    ),
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Retake')
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  Future<void> _scanImage() async {

  }
}