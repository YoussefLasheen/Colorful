import 'package:camera/camera.dart';
import 'package:colorful/utilities/camera.dart';
import 'package:colorful/widgets/error_frame_widget.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({Key? key, this.cameraIndex = -1}) : super(key: key);

  final int cameraIndex;

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Camera.initialize(widget.cameraIndex),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CameraPreview(snapshot.data as CameraController);
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
