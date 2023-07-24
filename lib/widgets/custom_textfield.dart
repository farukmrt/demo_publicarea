import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Color? color;
  final int? minlinee;
  final int? maxlinee;
  final String? textType;
  final bool? readOnly;

  const CustomTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.color,
    this.minlinee,
    this.maxlinee,
    this.textType,
    this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        readOnly: readOnly ?? false,
        controller: controller!,
        decoration: InputDecoration(
          suffixText: textType,
          filled: true,
          fillColor: color,
          labelText: labelText,
          labelStyle: const TextStyle(color: secondaryBackgroundColor),
          hintText: hintText,
          hintStyle: const TextStyle(color: secondaryBackgroundColor),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: buttonColor,
              width: 2,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: buttonColor,
            ),
          ),
        ),

        // if(minlinee != null)
        // minLines: minlinee,
        // maxLines: (minlinee! + 1),
      ),
    );
  }
}
