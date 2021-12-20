import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Camera {
  static Future<List<CameraDescription>> getAvailableCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await availableCameras();
  }

  static Future<CameraDescription> getFirstCamera() async {
    return (await getAvailableCameras()).first;
  }

  static Future<CameraDescription> getIndexCamera(int i) async {
    return (await getAvailableCameras())[i];
  }
}
