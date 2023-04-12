import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_scanner/constants/logic_constants.dart';
import 'package:text_scanner/main.dart';

class CameraScreenController extends GetxController {
  // ScreenMode _mode = ScreenMode.liveFeed;
  // CameraController? _controller;
  // File? _image;
  // String? _path;
  // ImagePicker? _imagePicker;
  // int _cameraIndex = -1;
  // double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;
  // final bool _allowPicker = true;
  // bool _changingCameraLens = false;
  ScreenMode _mode = ScreenMode.liveFeed;
  CameraController? _controller;
  Future<File?> _image = Future<File?>.value(null);
  RxString? _path;
  ImagePicker? _imagePicker;
  RxInt _cameraIndex = RxInt(-1);
  RxDouble zoomLevel = 0.0.obs, minZoomLevel = 0.0.obs, maxZoomLevel = 0.0.obs;
  RxBool _allowPicker = true.obs;
  RxBool _changingCameraLens = false.obs;
  @override
  void onInit() {
    super.onInit();
    _imagePicker = ImagePicker();
    if (cameras.any(
      (element) => element.lensDirection == CameraLensDirection.back && element.sensorOrientation == 90,
    )) {
      _cameraIndex.value = cameras.indexOf(cameras.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.back && element.sensorOrientation == 90,
      ));
    } else {
      for (var i = 0; i < cameras.length; i++) {
        if (cameras[i].lensDirection == CameraLensDirection.back) {
          _cameraIndex.value = i;
          break;
        }
      }
    }
    if (_cameraIndex.value == -1) {
      _cameraIndex.value = 0;
    }
    _controller = CameraController(cameras[_cameraIndex.value], ResolutionPreset.high);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  Future switchLiveCamera() async {
    if (_changingCameraLens.value) {
      return;
    }
    _changingCameraLens.value = true;
    if (_cameraIndex.value == 0) {
      _cameraIndex.value = 1;
    } else {
      _cameraIndex.value = 0;
    }
    await _controller!.dispose();
    _controller = CameraController(cameras[_cameraIndex.value], ResolutionPreset.high);
    await _controller!.initialize();
    _changingCameraLens.value = false;
  }
}
