import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomIconbutton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback ontap;

  const CustomIconbutton({
    Key? key,
    required this.title,
    required this.icon,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 3),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                icon,
                color: mainBackgroundColor,
              ),
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
