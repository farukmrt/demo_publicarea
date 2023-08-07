import 'package:flutter/material.dart';
import 'package:demo_publicarea/utils/colors.dart';

class CustomMainButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final IconData? icon;
  final EdgeInsets? edgeInsets;
  final Color? color;
  final Color? color_dis;
  final Color? color_act;

  const CustomMainButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.icon,
    this.edgeInsets,
    this.color,
    this.color_dis,
    this.color_act,
  }) : super(key: key);

  @override
  State<CustomMainButton> createState() => _CustomMainButtonState();
}

class _CustomMainButtonState extends State<CustomMainButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget
          .edgeInsets!, //custommain'e bu deger verilmediginde hata ekrani geliyor
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          foregroundColor: widget.color_act,
          disabledForegroundColor: widget.color_dis,
          minimumSize: const Size(double.infinity, 40),
        ),
        onPressed: widget.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                maxLines: 2,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                widget.text,
                style: const TextStyle(color: mainBackgroundColor),
              ),
            ),
            Flexible(child: Icon(widget.icon)),
          ],
        ),
      ),
    );
  }
}


//duzenlenecek silinebilirlik ozelligi
// Expanded(
//                 child: Consumer<DescriptionProvider>(
//                   builder: (context, provider, _) {
//                     List<Description> descriptions = provider.description;
//                     var uuid = Uuid(); // Uuid sınıfını oluşturun

//                     return ListView.builder(
//                       itemCount: descriptions.length,
//                       itemBuilder: (context, index) {
//                         Description description = descriptions[index];
//                         String uniqueKey =
//                             uuid.v4(); // Benzersiz bir kimlik oluşturun
//                         return Dismissible(
//                           key: Key(uniqueKey),
//                           onDismissed: (direction) {
//                             provider.removeDescription(description);
//                           },
//                           background: Container(
//                             color: negative,
//                             child: Icon(Icons.delete),
//                           ),
//                           child: CustomListItem(
//                             title: description.titlee,
//                             subtitle: description.subtitlee,
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               )