import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomCIconbutton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback ontap;
  final double? size;

  const CustomCIconbutton({
    Key? key,
    required this.title,
    required this.icon,
    required this.ontap,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: ontap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: mainBackgroundColor,
            ),
            Text(
              title,
              style: const TextStyle(
                color: mainBackgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
