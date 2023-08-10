import 'package:flutter/material.dart';

class CustomNumberedList extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? number;
  const CustomNumberedList({
    Key? key,
    this.title,
    this.subtitle,
    this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.all(1),
                child: Text(
                  title!,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(
                        text: number!,
                        style: const TextStyle(
                            color: Colors.black), // Başlık metninin rengi
                      ),
                      TextSpan(
                        text: subtitle!,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight
                                .w500), // Başlığın geri kalanının rengi
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
