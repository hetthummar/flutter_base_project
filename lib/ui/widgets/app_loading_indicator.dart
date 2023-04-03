import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        SizedBox(
          height: 24,
          width: 24,
          child:
          CircularProgressIndicator(
            color: Colors.white60,
            strokeWidth: 2.0,
          ),
        ),
      ],
    );
  }
}
