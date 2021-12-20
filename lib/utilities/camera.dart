import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Camera {
  static CameraController? _cameraController;
  static const _resolutionPreset = ResolutionPreset.max;

  static CameraController getCameraController() {
    if (_cameraController == null) {
      throw "Camera Controller is not initialized (Camera.initialize())";
    }
    return _cameraController as CameraController;
  }

  static Future<List<CameraDescription>> getAvailableCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await availableCameras();
  }

  static Future<CameraDescription> getFirstCamera() async {
    return (await getAvailableCameras()).first;
  }

  static Future<int> getCameraCount() async {
    return (await getAvailableCameras()).length;
  }

  static Future<CameraDescription> getIndexCamera(int i) async {
    final cameras = await getAvailableCameras();
    if (i > cameras.length || i < 0) {
      return getFirstCamera();
    }
    return (await getAvailableCameras())[i];
  }

  static Future<CameraController> initialize([int cameraIndex = -1]) async {
    await _initializeCameraController(cameraIndex);
    return getCameraController();
  }

  static Future<void> _initializeCameraController(int i) async {
    final CameraDescription camera;

    if (i <= 0) {
      camera = await Camera.getFirstCamera();
    } else {
      camera = await Camera.getIndexCamera(i);
    }

    _cameraController = CameraController(
      camera,
      _resolutionPreset,
    );

    await _cameraController?.initialize();
  }
}
