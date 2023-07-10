import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String mainTitle;
  final IconData? button;
  final VoidCallback? onTap;

  const CustomTitle({
    Key? key,
    required this.mainTitle,
    this.button,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      color: mainBackgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mainTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (button != null)
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: onTap,
                icon: Icon(button!),
              ),
            ),
        ],
      ),
    );
  }
}
