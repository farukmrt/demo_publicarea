import 'package:flutter/material.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/utils/languages/lang.dart';

class CustomDropdownButton extends StatelessWidget {
  final TextEditingController? controller;
  final String? value;
  final List<String>? items;
  final void Function(String?)? onChanged;
  final String? labelText;
  final String? Function(String?)? validator;

  const CustomDropdownButton({
    Key? key,
    this.value,
    this.items,
    this.onChanged,
    this.labelText,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropdownLabelText =
        labelText ?? '${translation(context).lcod_lbl_explanation}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<String>(
        value: value,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: mainBackgroundColor,
          labelText: dropdownLabelText,
          labelStyle: const TextStyle(color: secondaryBackgroundColor),
          // focusedBorder: const OutlineInputBorder(
          //   borderSide: BorderSide(
          //     color: buttonColor,
          //     width: 2,
          //   ),
          // ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(35.0),
          //   borderSide: const BorderSide(
          //     color: buttonColor,
          //   ),
          // ),
        ),
        onChanged: onChanged,
        items: items?.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }
}
