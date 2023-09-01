import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:demo_publicarea/utils/colors.dart';

class CustomRequestBigListItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final String text;
  final Widget? trailing;
  final Widget? leading;
  final Color? color;
  final FontStyle? fontstyle;
  final String? threeline;
  final String? image;
  final bool status;
  final bool isPositive;
  final String? resultDescription;

  const CustomRequestBigListItem({
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
    required this.status,
    required this.isPositive,
    this.resultDescription,
  }) : super(key: key);

  @override
  State<CustomRequestBigListItem> createState() =>
      _CustomRequestBigListItemState();
}

class _CustomRequestBigListItemState extends State<CustomRequestBigListItem> {
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
                    height: size.width,
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
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
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (widget.status == false)
              const SizedBox(
                height: 15,
              ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  widget.resultDescription!,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: widget.isPositive ? positive : negative),
                ),
              ),
            )
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