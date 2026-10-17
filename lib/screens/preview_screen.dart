import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vforms/schema/scanned_result.dart';
import 'package:vforms/screens/scan_results.dart';
import 'package:vforms/services/ocr.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<StatefulWidget> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  Ocr ocr = Ocr();
  bool isScanning = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ocr.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    ocr.dispose();
  }

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
                  File(widget.imagePath),
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

                            // Scanning process
                            ScannedResult result = await scan(widget.imagePath);

                            if(!context.mounted) return;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScanResultsScreen(
                                    scanResults: result,
                                  )
                              )
                            );
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

  Future<ScannedResult> scan(String imagePath) async {
    setState(() {
      isScanning = true;
    });

    var result = await ocr.scan(imagePath);

    setState(() {
      isScanning = false;
    });

    return result;
  }
}