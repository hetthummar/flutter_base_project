import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: SizedBox(
          height: 22,
          width: 22,
          child: Platform.isAndroid
              ? const CircularProgressIndicator(
                  strokeWidth: 2,
                )
              : const CupertinoActivityIndicator(
                  radius: 20,
                ),
        ),
      ),
    );
  }
}
