import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  Function callback;
  CustomBackButton(this.callback);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: const Icon(
        Icons.arrow_back,
        color: Colors.red,
      ),
    );
  }
}
