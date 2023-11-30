import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fajrApp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropDwonButton extends StatelessWidget {
  final String? value;
  final Widget? hint;
  final List<String>? items;
  final bool? isExpanded;
  final Widget? underline;
  final DropdownStyleData? dropdownStyleData;
  final ButtonStyleData? buttonStyleData;
  final IconStyleData? iconStyleData;
  final void Function(String?)? onChanged;

  const CustomDropDwonButton({
    super.key,
    this.value,
    this.hint,
    this.items,
    this.isExpanded,
    this.underline,
    this.dropdownStyleData,
    this.onChanged,
    this.buttonStyleData,
    this.iconStyleData,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      hint: hint ??
          Text(
            'Select One',
            style: $styles.text.labelLarge.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
      value: value,
      underline: underline ?? Container(),
      items: items
          ?.map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: $styles.text.labelLarge.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      isExpanded: isExpanded ?? true,
      iconStyleData: iconStyleData ??
          IconStyleData(
            icon: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(CupertinoIcons.chevron_down, color: $styles.colors.black),
            ),
            iconSize: 22,
          ),
      buttonStyleData: buttonStyleData ??
          ButtonStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: $styles.colors.black,
              ),
            ),
            elevation: 0,
          ),
      dropdownStyleData: dropdownStyleData ??
          DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: $styles.colors.white,
              border: Border.all(
                color: $styles.colors.black,
                width: 1,
              ),
            ),
          ),
    );
  }
}
