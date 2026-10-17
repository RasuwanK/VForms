import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:vforms/schema/scanned_result.dart';

class Ocr {
  TextRecognizer? _textRecognizer;
  Future<void>? _initializationFuture;

  bool _isDisposed = false;
  bool _isScanning = false;

  bool get isInitialized => _textRecognizer != null && !_isDisposed;

  // Initializing only once
  Future<void> initialize() async {
    if(_isDisposed) {
      return Future.error(
        StateError("OCR has already been disposed")
      );
    }

    if (_textRecognizer != null) {
      return Future.value();
    }

    return _initializationFuture ??= _initializeInternal();
  }

  Future<void> _initializeInternal() async {
    try {
      _textRecognizer = TextRecognizer(
        script: TextRecognitionScript.latin
      );
    } catch (e) {
      _initializationFuture = null;
      rethrow;
    }
  }

  Future<void> dispose () async {
    if(_isDisposed) return;

    _isDisposed = true;

    try {
      await _initializationFuture;
    } catch (e) {
      // Initialization failed there will be nothing to close
    }

    final recognizer = _textRecognizer;
    _textRecognizer = null;

    await recognizer?.close();
  }

  Future<ScannedResult> scan(String imagePath) async {

    if (_textRecognizer == null) {
      throw StateError("OCR is not initialized");
    }

    try {
      _isScanning = true;
      final RecognizedText recognizedText = await _textRecognizer!.processImage(InputImage.fromFilePath(imagePath));

      return ScannedResult.fromBlocks(recognizedText.blocks);
    } catch(_) {
      _isScanning = false;
      rethrow;
    } finally {
      _isScanning = false;
    }

  }
}
