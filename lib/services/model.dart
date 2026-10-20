import 'package:flutter_edge_ai/flutter_edge_ai.dart';
import 'package:flutter_edge_ai_litertlm/flutter_edge_ai_litertlm.dart';

class Model {
  bool _isInitialized = false;
  bool _isDisposed = false;
  bool _isModelInstalled = false;
  bool _isChatInitialized = false;

  int installProgress = 0;

  Future<void>? _initializationFuture;
  Future<void>? _installFuture;
  Future<void>? _createChatFuture;

  InferenceChat? chat;
  InferenceModel? model;

  Future<void> initialize(String? token) async {
    if (_isInitialized) {
      return Future.value();
    }

    return _initializationFuture ??= _initializeInternal(token);
  }

  Future<void> installModel(void Function(int) onProgress) async {
    if (model != null) {
      return Future.value();
    }

    return _installFuture ??= _installModelInternal(onProgress);
  }

  Future<void> createChat() async {
    if (chat != null) {
      return Future.value();
    }

    return _createChatFuture ??= _createChatInternal();
  }

  Future<void> _createChatInternal() async {
    try {
      model = await FlutterEdgeAi.getActiveModel(maxTokens: 2048);
      chat = await model!.createChat();

      _isChatInitialized = true;
    } catch(_) {
      _isChatInitialized = false;
      rethrow;
    }
  }

  Future<void> closeChat() async {
    try {
      await _createChatFuture;

      if (chat == null) {
        throw StateError("Chat is not initialized");
      }

      await chat!.close();
      _isChatInitialized = false;
    } catch(_) {
      rethrow;
    }
  }

  Future<StringBuffer> sendMessage(String message) async {
    if (chat == null) {
      throw StateError("Chat is not initialized");
    }

    if (model == null) {
      throw StateError("Model is not initialized");
    }

    await chat!.addQueryChunk(Message.text(text: message, isUser: true));

    final reply = StringBuffer();

    await for (final response in chat!.generateChatResponseAsync()) {
      if (response is TextResponse) reply.write(response.token);
    }

    return reply;
  }

  bool get isChatInitialized => _isChatInitialized;
  bool get isModelInstalled => _isModelInstalled;
  bool get isInitialized => _isInitialized;
  bool get isDisposed => _isDisposed;

  Future<void> _installModelInternal(void Function(int) onProgress) async {
    _isModelInstalled = false;

    try {
      await FlutterEdgeAi.installModel(
        modelType: ModelType.gemmaIt,
        fileType: ModelFileType.litertlm, // selects the engine — declare it
      ).fromNetwork(
        'https://huggingface.co/litert-community/Gemma3-1B-IT/resolve/main/Gemma3-1B-IT_multi-prefill-seq_q4_ekv4096.litertlm',
      ).withProgress((progress) => onProgress(progress)).install();

      _isModelInstalled = true;
    } catch(_) {
      _isModelInstalled = false;
      rethrow;
    }
  }

  Future<void> dispose() async {
    // TODO: Implement dispose
    _isDisposed = true;
  }

  Future<void> _initializeInternal(String? token) async {
    try {
      await FlutterEdgeAi.initialize(
        // Inference engines — add the ones whose packages you depend on:
        inferenceEngines: const [
          LiteRtLmEngine(),     // flutter_edge_ai_litertlm  — .litertlm models
        ],

        // Common settings:
        // String.fromEnvironment yields '' when the define is absent, and an
        // empty token still sends a bare `Authorization: Bearer` header. Pass
        // null instead so the request goes out unauthenticated.
        huggingFaceToken: token,
        maxDownloadRetries: 10,
      );
    } catch(_) {
      _isInitialized = false;
      _initializationFuture = null;
      rethrow;
    }
  }
}