import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
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
              margin: const EdgeInsets.fromLTRB(5, 8, 5, 8),
              color: mainBackgroundColor,
              child: ListTile(
                trailing: trailing,
                leading: leading,
                title: Text(
                  title,
                  style: TextStyle(fontStyle: fontstyle),
                ),
                subtitle: Text(
                  subtitle,
                  style: TextStyle(color: color),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}