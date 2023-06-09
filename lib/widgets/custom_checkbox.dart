import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomCheckBoxListItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final Widget? leading;
  final Color? color;
  final FontStyle? fontstyle;
  final Function(bool?) onChanged;
  final bool? valuee;

  final dynamic mainList;

  const CustomCheckBoxListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.leading,
    this.color,
    this.fontstyle,
    //required this.valuee,
    required this.onChanged,
    required this.valuee,
    this.mainList,
  }) : super(key: key);

  @override
  State<CustomCheckBoxListItem> createState() => _CustomCheckBoxListItemState();
}

@override
State<CustomCheckBoxListItem> createState() => _CustomCheckBoxListItemState();

class _CustomCheckBoxListItemState extends State<CustomCheckBoxListItem> {
  //bool _isChecked = false;
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
                controlAffinity: ListTileControlAffinity.leading,
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
                value: widget.valuee, //_isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    widget.onChanged(value);
                  });
                },

                // onChanged: (bool? value) {
                //   if (widget.onChanged != null) {
                //     widget.onChanged(value!);
                //   }
                //   if (value == true) {
                //     setState(() {
                //       widget.selectedList.add(widget.mainList);
                //     });
                //   } else {
                //     setState(() {
                //       widget.selectedList.remove(widget.mainList);
                //     });
                //   }
                // },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
