import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomCheckBoxListItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final Widget? leading;
  final Color? color;
  final FontStyle? fontstyle;

  const CustomCheckBoxListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.leading,
    this.color,
    this.fontstyle,
  }) : super(key: key);

  @override
  State<CustomCheckBoxListItem> createState() => _CustomCheckBoxListItemState();
}

class _CustomCheckBoxListItemState extends State<CustomCheckBoxListItem> {
  final bool _isChecked = false;
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
              child: CheckboxListTile(
                value: _isChecked,
                onChanged: (bool? newValue) {
                  setState(() {
                    //setState icerisnde duzenleme lazim
                    //var _isChecked = newValue;
                  });
                },
                secondary: widget.leading,
                title: Text(
                  widget.title,
                  style: TextStyle(fontStyle: widget.fontstyle),
                ),
                subtitle: Text(
                  widget.subtitle,
                  style: TextStyle(color: widget.color),
                  overflow: TextOverflow.ellipsis,
                ),
                autofocus: false,
                activeColor: paidc,
                checkColor: Colors.white,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
