import 'package:camera/camera.dart';
import 'package:colorful/utilities/camera.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({Key? key, this.cameraIndex = -1}) : super(key: key);

  final int cameraIndex;

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _initializeCameraController() async {
    final CameraDescription camera;

    if (widget.cameraIndex == -1) {
      camera = await Camera.getFirstCamera();
    } else {
      camera = await Camera.getIndexCamera(widget.cameraIndex);
    }

    _controller = CameraController(
      camera,
      ResolutionPreset.max,
    );

    await _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeCameraController(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(_controller);
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
