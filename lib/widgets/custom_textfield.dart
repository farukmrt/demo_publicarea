import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  const CustomTextField({Key? key, required this.controller, this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: secondaryBackgroundColor),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: buttonColor,
              width: 2,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: secondaryBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
