import 'package:colorful/utilities/camera.dart';
import 'package:flutter/material.dart';

class CameraSwitchButton extends StatelessWidget {
  const CameraSwitchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _onPressed,
      icon: const Icon(
        Icons.refresh,
      ),
    );
  }

  void _onPressed() {
    Camera.switchCamera();
  }
}
