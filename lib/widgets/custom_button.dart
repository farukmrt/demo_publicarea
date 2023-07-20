import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomIconbutton extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;
  final String? rightText;
  final double? size;
  final Opacity? opacity;
  //final TextField? textff;

  const CustomIconbutton({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
    this.color,
    this.rightText,
    this.size,
    this.opacity,
    //this.textff,
  }) : super(key: key);

  @override
  State<CustomIconbutton> createState() => _CustomIconbuttonState();
}

class _CustomIconbuttonState extends State<CustomIconbutton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 1, 5, 3),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.color),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: widget.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                widget.icon,
                color: mainBackgroundColor,
                size: widget.size,
              ),
            ),
            Column(
              children: [
                if (widget.rightText != null)
                  Text(
                    widget.rightText!,
                    style: const TextStyle(
                      color: mainBackgroundColor,
                    ),
                  ),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: mainBackgroundColor,
                  ),
                ),

                // Text(
                //   rightText!,
                //   style: const TextStyle(
                //     color: mainBackgroundColor,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
