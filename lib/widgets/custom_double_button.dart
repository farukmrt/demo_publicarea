import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomDoubleIconbutton extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;
  final String? rightText;
  final double? size;
  //final Opacity? opacity;

  const CustomDoubleIconbutton({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
    this.color,
    this.rightText = '',
    this.size,
    //this.opacity,
  }) : super(key: key);

  @override
  State<CustomDoubleIconbutton> createState() => _CustomDoubleIconbuttonState();
}

class _CustomDoubleIconbuttonState extends State<CustomDoubleIconbutton> {
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
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
              child: Column(
                children: [
                  Text(
                    widget.rightText!,
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    style: const TextStyle(
                      color: mainBackgroundColor,
                    ),
                  ),
                  Text(
                    widget.title,
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    style: const TextStyle(
                      color: mainBackgroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
