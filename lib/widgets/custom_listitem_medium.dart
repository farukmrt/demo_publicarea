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
  final String? image;
  final Image? imagee;

  const CustomMediumListItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.text,
      this.trailing,
      this.leading,
      this.color,
      this.fontstyle,
      this.threeline,
      this.imagee,
      this.image})
      : super(key: key);

  @override
  State<CustomMediumListItem> createState() => _CustomMediumListItemState();
}

class _CustomMediumListItemState extends State<CustomMediumListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
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
                    maxLines: 2),
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
              // FadeInImage(
              //   height: 150,
              //   placeholder: AssetImage(
              //       'assets/placeholder.png'), // Yüklenirken görünecek görsel
              //   image: NetworkImage('${widget.image}'),
              //   fit: BoxFit.cover,
              //   imageErrorBuilder: (BuildContext context, Object exception,
              //       StackTrace? stackTrace) {
              //     return Container(
              //       height: 150,
              //       decoration: BoxDecoration(
              //         color: Colors
              //             .grey, // Hata durumunda gösterilecek arkaplan rengi
              //         borderRadius: BorderRadius.vertical(
              //             bottom: Radius.circular(35), top: Radius.circular(5)),
              //       ),
              //       child: Center(
              //         child: Icon(Icons.error, color: Colors.white),
              //       ),
              //     );
              //   },
              // ),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: buttonColor2,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(35), top: Radius.circular(5)),
                  image: DecorationImage(
                    //height: double.infinity,
                    fit: BoxFit.cover,
                    image: NetworkImage('${widget.image}'),
                    // repeat: ImageRepeat.repeat,
                    // loadingBuilder: (context, child, loadingProgress) {
                    //   if (loadingProgress == null) {
                    //     return child;
                    //   } else {
                    //     return LoadingIndicator();
                    //   }
                    // },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
