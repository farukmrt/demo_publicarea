import 'package:flutter/material.dart';
import 'package:demo_publicarea/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          minimumSize: const Size(double.infinity, 40),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(color: mainBackgroundColor),
        ),
      ),
    );
  }
}
