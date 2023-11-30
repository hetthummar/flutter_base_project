// ignore_for_file: must_be_immutable, prefer_if_null_operators

import 'package:fajrApp/main.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final int? maxLength;
  final int? maxLines;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool readOnly ;

  const CustomTextField({
    Key? key,
    this.hintText,
    required this.controller,
    this.validator,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.onChanged,
    this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
    this.contentPadding,
    this.onTap,
    this.readOnly = false,
    this.errorBorder,
    this.focusedBorder,
    this.enabledBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            onTap: onTap,
            keyboardType: keyboardType ?? TextInputType.text,
            cursorColor: $styles.colors.black,
            cursorHeight: 22,
            maxLength: maxLength,
            maxLines: maxLines,
            readOnly: readOnly,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              filled: true,
              fillColor: $styles.colors.white,
              errorBorder: errorBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: $styles.colors.error,
                    ),
                  ),
              focusedBorder: focusedBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: $styles.colors.black,
                    ),
                  ),
              enabledBorder: enabledBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: $styles.colors.black,
                    ),
                  ),
              hintText: hintText,
              hintStyle: $styles.text.bodyLarge.copyWith(
                color: Colors.grey,
              ),
              prefix: prefix == null ? null : prefix,
              prefixIcon: prefixIcon == null ? null : prefixIcon,
              suffix: suffix == null ? null : suffix,
              suffixIcon: suffixIcon == null ? null : suffixIcon,
              contentPadding: contentPadding,
            ),
          ),
        ),
      ],
    );
  }
}