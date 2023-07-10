import 'package:flutter/material.dart';

class CustomTextBlock extends StatelessWidget {
  final String maintext;
  final String? subtext;

  const CustomTextBlock({
    required this.maintext,
    this.subtext,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          textAlign: TextAlign.center,
          maintext,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          textAlign: TextAlign.center,
          subtext!,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ]),
    );
  }
}
