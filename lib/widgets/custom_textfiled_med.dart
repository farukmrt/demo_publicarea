import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFieldMedium extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Color? color;
  final int? minlinee;
  final int? maxlinee;
  final int? maxLength;
  final String? Function(String?)? validator;

  const CustomTextFieldMedium({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.color,
    this.minlinee,
    this.maxlinee,
    this.maxLength,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: validator,
        maxLength: maxLength,
        //35. satır açılırsa sayaç gözükmeyecektir(counterText)
        minLines: 2,
        maxLines: 4,
        controller: controller!,
        decoration: InputDecoration(
          // counterText: '',
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
      ),
    );
  }
}
