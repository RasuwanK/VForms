import 'dart:ui';
import 'dart:math';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ScannedBlock {
  final Rect boundingBox;
  final List<Point<int>> cornerPoints;
  final String text;

  ScannedBlock({
    required this.boundingBox,
    required this.cornerPoints,
    required this.text,
  });

  ScannedBlock.fromTextBlock(TextBlock textBlock)
    : boundingBox = textBlock.boundingBox,
      text = textBlock.text,
      cornerPoints = textBlock.cornerPoints;

  Map<String, dynamic> toJson() => {
    'boundingBox': {
      'top': boundingBox.top,
      'left': boundingBox.left,
      'bottom': boundingBox.bottom,
      'right': boundingBox.right,
    },
    'cornerPoints': cornerPoints
        .map((point) => {'x': point.x, 'y': point.y})
        .toList(),
    'text': text,
  };
}

class ScannedResult {
  final List<ScannedBlock> blocks;

  ScannedResult({required this.blocks});

  ScannedResult.fromBlocks(List<TextBlock> blocks)
    : blocks = blocks
          .map((block) => ScannedBlock.fromTextBlock(block))
          .toList();

  Map<String, dynamic> toJson() => {
    'blocks': blocks.map((block) => block.toJson()).toList(),
  };
}
