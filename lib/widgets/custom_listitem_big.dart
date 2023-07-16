import 'package:flutter/material.dart';
import 'package:demo_publicarea/utils/colors.dart';

class CustomBigListItem extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String text;
  final Widget? trailing;
  final Widget? leading;
  final Color? color;
  final FontStyle? fontstyle;
  final String? threeline;

  // final bool? isCheckeda;
  // final bool? isCheckBoxa;

  const CustomBigListItem({
    Key? key,
    required this.title,
    this.subtitle,
    required this.text,
    this.trailing,
    this.leading,
    this.color,
    this.fontstyle,
    this.threeline,
    // this.isCheckBoxa,
    // this.isCheckeda,
  }) : super(key: key);

  @override
  State<CustomBigListItem> createState() => _CustomBigListItemState();
}

class _CustomBigListItemState extends State<CustomBigListItem> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            ListTile(
              trailing: widget.trailing,
              leading: widget.leading,
              title: Text(
                widget.title,
                style: TextStyle(
                  fontStyle: widget.fontstyle,
                ),
              ),
              subtitle: Text(
                widget.subtitle!,
                style: TextStyle(
                  color: widget.color,
                ),

                // alttaki kod verilerin tek satir ve sonunda '...' olmasini sagliyor
                //overflow: TextOverflow.ellipsis),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.text,
                style: TextStyle(
                  fontStyle: widget.fontstyle,
                ),
              ),
            ),
            Image(image: AssetImage('assets/images/announcement_image1.png')),
          ],
        ),
      ),
    );
  }
}