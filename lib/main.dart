import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:text_scanner/views/app_view.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const AppView());
}
