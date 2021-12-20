import 'package:flutter/material.dart';

class ErrorFrameWidget extends StatelessWidget {
  const ErrorFrameWidget({Key? key, this.message}) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).errorColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Error",
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            message ?? "There was an error",
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
