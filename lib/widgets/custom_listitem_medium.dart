import 'package:flutter/material.dart';
import 'package:demo_publicarea/utils/colors.dart';

class CustomMediumListItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final String text;
  final Widget? trailing;
  final Widget? leading;
  final Color? color;
  final FontStyle? fontstyle;
  final String? threeline;

  // final bool? isCheckeda;
  // final bool? isCheckBoxa;

  const CustomMediumListItem({
    Key? key,
    required this.title,
    required this.subtitle,
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
  State<CustomMediumListItem> createState() => _CustomMediumListItemState();
}

class _CustomMediumListItemState extends State<CustomMediumListItem> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.fromLTRB(5, 3, 5, 3),
              color: mainBackgroundColor,
              child: Column(
                children: [
                  ListTile(
                    trailing: widget.trailing,
                    leading: widget.leading,
                    title: Text(widget.title,
                        style: TextStyle(
                          fontStyle: widget.fontstyle,
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 2 // overflow: TextOverflow.ellipsis),
                        ),
                    subtitle: Text(
                      widget.subtitle,
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
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  Image(
                      image:
                          AssetImage('assets/images/announcement_image1.png')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
