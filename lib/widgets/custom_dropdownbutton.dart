import 'package:flutter/material.dart';
import 'package:demo_publicarea/utils/colors.dart';

class CustomDropdownButton extends StatelessWidget {
  final String? value;
  final List<String>? items;
  final void Function(String?)? onChanged;
  final String? labelText;

  const CustomDropdownButton({
    Key? key,
    this.value,
    this.items,
    this.onChanged,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropdownLabelText = labelText ?? 'Seçim Yapın';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          //contentPadding: const EdgeInsets.symmetric(vertical: 10),
          filled: true,
          fillColor: mainBackgroundColor,
          labelText: dropdownLabelText,
          labelStyle: const TextStyle(color: secondaryBackgroundColor),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: buttonColor,
              width: 2,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            //borderRadius: BorderRadius.all(Radius.circular(34)),
            //gapPadding: 40.0,
            borderSide: BorderSide(
              color: buttonColor,
            ),
          ),
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
