import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

Future<String> copyAssetToFile(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);

  final directory = await getApplicationSupportDirectory();
  final fileName = assetPath.split('/').last;
  final file = File('${directory.path}/$fileName');

  await file.writeAsBytes(
    byteData.buffer.asUint8List(
      byteData.offsetInBytes,
      byteData.lengthInBytes,
    ),
    flush: true,
  );

  return file.path;
}