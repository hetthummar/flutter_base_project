import 'package:baseproject/utils/app_util.dart';
import 'package:flutter/material.dart';

class passwordTextField extends StatefulWidget {
  Function continueBtnActiveCallback;
  TextEditingController passwordController;
  bool showPassword = false;

  passwordTextField(this.continueBtnActiveCallback,this.passwordController);

  @override
  State<passwordTextField> createState() => _passwordViewState();
}

class _passwordViewState extends State<passwordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      onChanged: (text) {
        if (AppUtils().isValidPassword(text)) {
            widget.continueBtnActiveCallback(true);
        } else {
            widget.continueBtnActiveCallback(false);
        }
      },
      obscureText: !widget.showPassword,
      decoration: InputDecoration(
        hintText: "Password",
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              widget.showPassword = !widget.showPassword;
            });
          },
          child: widget.showPassword
              ? const Icon(Icons.remove_red_eye_rounded)
              : const Icon(Icons.remove_red_eye_rounded,color: Colors.grey,),
        ),
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.only(left: 16, right: 4, top: 12, bottom: 12),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black38, width: 1.0),
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}
