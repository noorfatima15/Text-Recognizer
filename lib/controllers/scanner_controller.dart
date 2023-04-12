import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:text_scanner/utils/text_recognizer_painter.dart';

class ScannerController extends GetxController {
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.chinese);
  RxBool _canProcess = true.obs;
  RxBool _isBusy = false.obs;
  Rx<CustomPaint?> _customPaint = Rx<CustomPaint?>(null);
  RxString? _text;
  @override
  void dispose() async {
    _canProcess = false.obs;
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess.value) return;
    if (_isBusy.value) return;
    _isBusy.value = true;
    _text = ''.obs;
    final recognizedText = await _textRecognizer.processImage(inputImage);
    if (inputImage.inputImageData?.size != null && inputImage.inputImageData?.imageRotation != null) {
      final painter = TextRecognizerPainter(recognizedText, inputImage.inputImageData!.size, inputImage.inputImageData!.imageRotation);
      _customPaint.value = CustomPaint(painter: painter);
    } else {
      _text = 'Recognized text:\n\n${recognizedText.text}'.obs;
    }
    _isBusy.value = false;
  }
}
