import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vforms/schema/scanned_result.dart';

class ScanResultsScreen extends StatefulWidget {
  const ScanResultsScreen({super.key, required this.scanResults});

  final ScannedResult scanResults;

  @override
  State<StatefulWidget> createState() => _ScanResultsScreenState();
}

class _ScanResultsScreenState extends State<ScanResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Results'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (final block in widget.scanResults.blocks)
            Padding(
              padding: const EdgeInsets.only(
                bottom: 12
              ),
              child: Text(
                jsonEncode(block.toJson())
              ),
            )
        ],
      )
    );
  }
}