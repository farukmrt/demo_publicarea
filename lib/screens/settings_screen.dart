import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
    );
  }
}



//  children: [
//         // CustomTextField(
//         //   controller: ,
//         //   labelText: 'İsminizi giriniz',
//         // ), CustomTextField(
//         //   controller: controller,
//         //   labelText: 'Soyisminizi giriniz',
//         // ), CustomTextField(
//         //   controller: controller,
//         //   labelText: 'Oturduğunuz binanın adını giriniz',
//         // ),
//       ],