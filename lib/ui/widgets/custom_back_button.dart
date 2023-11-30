import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Function? callback;
  const CustomBackButton(this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback!();
      },
      child: const Icon(
        Icons.arrow_back,
        color: Colors.red,
      ),
    );
  }
}
