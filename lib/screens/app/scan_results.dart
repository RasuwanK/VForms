import 'dart:convert';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:vforms/schema/scanned_result.dart';

class ScanResultsScreen extends StatefulWidget {
  const ScanResultsScreen({super.key, required this.scanResults});

  final ScannedResult scanResults;

  @override
  State<StatefulWidget> createState() => _ScanResultsScreenState();
}

class _ScanResultsScreenState extends State<ScanResultsScreen> {
  final model = FirebaseAI.googleAI().generativeModel(model: "gemini-3.8-flash");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Results'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

        ],
      )
    );
  }
}