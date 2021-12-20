import 'package:colorful/widgets/camera_switch_button.dart';
import 'package:colorful/widgets/camera_widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            const CameraWidget(),
            const Expanded(
              child: CameraSwitchButton(),
            ),
          ],
        ),
      ),
    );
  }
}
