import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_paddle_ocr/flutter_paddle_ocr.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vforms/utils/load_model.dart';

class Ocr {
  late ModelSource source;
  late PaddleOcr ocr;

  Ocr();

  // Initializing paddle OCR
  Future<void> initialize() async {

    if (kIsWeb) {
      source = const ModelSource.bundled(lang: 'en', version: 'PP-OCRv5');
    } else {
      final detPath = await copyAssetToFile('assets/models/det_db.nb');
      final recPath = await copyAssetToFile('assets/models/rec_crnn.nb');
      final clsPath = await copyAssetToFile('assets/models/cls.nb');

      final dictPath = await copyAssetToFile('assets/models/ppocr_keys_v1.txt');

      source = kIsWeb
          ? const ModelSource.bundled(lang: 'en', version: 'PP-OCRv5')
          : ModelSource.filePaths(
        det: detPath,
        rec: recPath,
        dict: dictPath,
        cls: clsPath, // optional — enables angle classification
      );
    }

    ocr = await PaddleOcr.create(source: source);
  }

  Future<List<OcrResult>> detect(Uint8List image) async {
    final results = await ocr.recognize(image);
    return results;
  }

  void dispose() {
    ocr.dispose();
  }
}
