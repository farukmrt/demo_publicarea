import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String mainTitle;
  const CustomTitle({Key? key, required this.mainTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      color: mainBackgroundColor,
      child: Center(
        child: Text(
          mainTitle,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
