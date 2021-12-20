import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Camera {
  static const _resolutionPreset = ResolutionPreset.max;

  static CameraController? _cameraController;
  static CameraLensDirection? _lensDirection;
  static final List<VoidCallback> _callbackOnChange =
      List.empty(growable: true);

  static CameraController getCameraController() {
    if (_cameraController == null) {
      throw "Camera Controller is not initialized (Camera.initialize())";
    }
    return _cameraController as CameraController;
  }

  static Future<List<CameraDescription>> _getAvailableCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await availableCameras();
  }

  static Future<CameraDescription> _getCameraByLensDirection(
      CameraLensDirection direction) async {
    final cameras = await _getAvailableCameras();
    for (var camera in cameras) {
      if (camera.lensDirection == direction) {
        return camera;
      }
    }
    return cameras.first;
  }

  static int addOnChangeCallback(VoidCallback callback) {
    _callbackOnChange.add(callback);
    return _callbackOnChange.length - 1;
  }

  static void removeOnChangeCallback(int i) {
    _callbackOnChange.removeAt(i);
  }

  static Future<CameraController> initialize(
      [CameraLensDirection? direction]) async {
    direction ??= CameraLensDirection.front;
    await _initializeCameraController(direction);
    _executeCallback();
    return getCameraController();
  }

  static void dispose() {
    _cameraController?.dispose();
  }

  static Future<void> switchCamera() async {
    switch (_lensDirection) {
      case CameraLensDirection.front:
        await initialize(CameraLensDirection.back);
        break;
      case CameraLensDirection.back:
        await initialize(CameraLensDirection.front);
        break;
      default:
        await initialize();
    }
  }

  static void _executeCallback() {
    for (var element in _callbackOnChange) {
      element();
    }
  }

  static Future<void> _initializeCameraController(
      CameraLensDirection direction) async {
    final camera = await _getCameraByLensDirection(direction);

    _lensDirection = camera.lensDirection;
    _cameraController = CameraController(
      camera,
      _resolutionPreset,
    );

    await _cameraController?.initialize();
  }
}
