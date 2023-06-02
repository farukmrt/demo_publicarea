import 'package:flutter/material.dart';

class CustomSubtitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  const CustomSubtitle({Key? key, required this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 6),
            child: Text(title),
          ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
              child: Text(subtitle!),
            ),
        ],
      ),
    );
  }
}
