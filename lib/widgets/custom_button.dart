import 'package:flutter/material.dart';
import 'package:demo_publicarea/utils/colors.dart';

class CustomIconbutton extends StatefulWidget {
  final String title;
  final IconData icon;
  final double? textSize;
  final VoidCallback? onTap;
  final Color? color;
  final String? rightText;
  final double? size;
  final Opacity? opacity;
  final TextAlign? textAlign;

  const CustomIconbutton({
    Key? key,
    required this.title,
    required this.icon,
    this.textSize,
    this.onTap,
    this.color,
    this.rightText,
    this.size,
    this.opacity,
    this.textAlign = TextAlign.start,
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
              borderRadius: BorderRadius.circular(35),
            ),
          ),
        ),
        onPressed: widget.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  widget.icon,
                  color: mainBackgroundColor,
                  size: widget.size,
                ),
              ),
            ),
            Flexible(
              child: Text(
                widget.title,
                textAlign: widget.textAlign,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: widget.textSize,
                  color: mainBackgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
