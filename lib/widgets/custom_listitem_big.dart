import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:demo_publicarea/utils/colors.dart';

class CustomBigListItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final String text;
  final Widget? trailing;
  final Widget? leading;
  final Color? color;
  final FontStyle? fontstyle;
  final String? threeline;
  final String? image;

  const CustomBigListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.text,
    this.trailing,
    this.leading,
    this.color,
    this.fontstyle,
    this.threeline,
    this.image,
  }) : super(key: key);

  @override
  State<CustomBigListItem> createState() => _CustomBigListItemState();
}

class _CustomBigListItemState extends State<CustomBigListItem> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              ),
            ),
            if (widget.image != null)
              Container(
                height: size.width,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: buttonColor2,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    child: Image.network(
                      widget.image!,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return LoadingIndicator();
                        }
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
//  Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: buttonColor2,
//                   borderRadius: BorderRadius.vertical(
//                       bottom: Radius.circular(35), top: Radius.circular(5)),

//                   //child: Padding(
//                   // padding: const EdgeInsets.all(15),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: NetworkImage(
//                       widget.image!,
//                       // loadingBuilder: (BuildContext context, Widget child,
//                       //     ImageChunkEvent? loadingProgress) {
//                       //   if (loadingProgress == null) {
//                       //     return child;
//                       //   } else {
//                       //     return LoadingIndicator();
//                       //   }
//                       // },
//                     ),
//                   ),
//                 ),
//               ),