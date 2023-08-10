import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Color? color;
  final int? minlinee;
  final int? maxlinee;
  final String? textType;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final bool? obscore;
  final Function? listenValue;
  final VoidCallback? onChanged;
  final String? errorText;
  final OutlineInputBorder? errorBorder;
  final int? maxLength;
  final String? Function(String?)? validator;

  final AutovalidateMode? autovalidate;

  const CustomTextField(
      {Key? key,
      this.controller,
      this.labelText,
      this.hintText,
      this.color,
      this.minlinee,
      this.maxlinee,
      this.textType,
      this.readOnly,
      this.keyboardType,
      this.obscore = false,
      this.listenValue,
      this.onChanged,
      this.errorText,
      this.errorBorder,
      this.maxLength,
      this.autovalidate,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: validator,
        autovalidateMode: autovalidate,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,

        onTap: onChanged,
        readOnly: readOnly ?? false,

        controller: controller!,
        onChanged: (value) {
          listenValue?.call(value);
        },
        //klavyenin yanlizca numara göstermesini saglayan kisim
        //telefon numarasi istenen yerlerde kullaniyoruz varsayilan
        ////girilmediginde normal klavye getirir.
        keyboardType: keyboardType,
        //obscore false iken deger gozukur, true iken gozukmez
        // bu sebeple varsayilan olarak false verdik sifre kisimlarinda true atadik
        obscureText: obscore!,
        decoration: InputDecoration(
          counterText: '',
          errorText: errorText,
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
          errorBorder: errorBorder ??
              OutlineInputBorder(
                borderSide: BorderSide(
                  color: negative,
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
