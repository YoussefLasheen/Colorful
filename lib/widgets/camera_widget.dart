import 'package:camera/camera.dart';
import 'package:colorful/utilities/camera.dart';
import 'package:colorful/widgets/error_frame_widget.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({Key? key}) : super(key: key);

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late Future<CameraController>? _cameraInitFuture;

  @override
  void initState() {
    _cameraInitFuture = Camera.initialize();
    Camera.addOnChangeCallback(_callbackOnCameraChange);
    super.initState();
  }

  void _callbackOnCameraChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _cameraInitFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CameraPreview(Camera.getCameraController());
        } else if (snapshot.hasError) {
          return ErrorFrameWidget(
            message: snapshot.error?.toString(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
