import 'package:flutter/material.dart';
import 'package:demo_publicarea/utils/colors.dart';

class CustomListItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final Widget? leading;
  final Color? color;
  final FontStyle? fontstyle;

  const CustomListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.leading,
    this.color,
    this.fontstyle,
  }) : super(key: key);

  @override
  State<CustomListItem> createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
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
              child: ListTile(
                trailing: widget.trailing,
                leading: widget.leading,
                title: Text(
                  widget.title,
                  style: TextStyle(
                      fontStyle: widget.fontstyle,
                      overflow: TextOverflow.ellipsis),
                ),
                subtitle: Text(widget.subtitle,
                    style: TextStyle(color: widget.color),
                    // alttaki kod verilerin tek satir ve sonunda '...' olmasini sagliyor
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
