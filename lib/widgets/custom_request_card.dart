import 'package:flutter/material.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';

class CustomRequestCard extends StatefulWidget {
  final String requestType;
  final String requestTitle;
  final String apartmentNumber;
  final bool status;
  final VoidCallback onTap;
  final Color? color;

  const CustomRequestCard({
    required this.requestType,
    required this.requestTitle,
    required this.apartmentNumber,
    required this.status,
    required this.onTap,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomRequestCard> createState() => _CustomRequestCardState();
}

class _CustomRequestCardState extends State<CustomRequestCard> {
  String _currentRequestType = '';
  Icon? requestIcon;
  Color? selectedColor;
  Color? selectedBackground;

  @override
  void initState() {
    super.initState();
    _currentRequestType = widget.requestType;
  }

  @override
  Widget build(BuildContext context) {
    var trnslt = AppLocalizations.of(context)!;
    String statusText =
        widget.status ? trnslt.lcod_lbl_pending : trnslt.lcod_lbl_concluded;

    // ignore: unused_local_variable
    Icon statusIcon = (widget.status
        ? const Icon(Icons.update_outlined)
        : const Icon(Icons.task_alt_outlined));

    if (_currentRequestType == 'lcod_lbl_request_malfunction') {
      _currentRequestType = trnslt.lcod_lbl_request_malfunction;
      requestIcon = const Icon(
        Icons.troubleshoot_outlined,
        color: iconColor1,
      );
      selectedColor = iconColor1;
      selectedBackground = color1Background;
    }

    if (_currentRequestType == 'lcod_lbl_request_question') {
      _currentRequestType = trnslt.lcod_lbl_request_question;
      requestIcon = const Icon(
        Icons.contact_support_outlined,
        color: iconColor2,
      );
      selectedColor = iconColor2;
      selectedBackground = color2Background;
    }
    if (_currentRequestType == 'lcod_lbl_request_suggestion') {
      _currentRequestType = trnslt.lcod_lbl_request_suggestion;
      requestIcon = const Icon(
        Icons.edit_note_outlined,
        color: iconColor3,
      );
      selectedColor = iconColor3;
      selectedBackground = color3Background;
    }
    if (_currentRequestType == 'lcod_lbl_request_complaint') {
      _currentRequestType = trnslt.lcod_lbl_request_complaint;
      requestIcon = const Icon(
        Icons.do_not_disturb_on_outlined,
        color: iconColor4,
      );
      selectedColor = iconColor4;
      selectedBackground = color4Background;
    }
    if (_currentRequestType == 'lcod_lbl_request_request') {
      _currentRequestType = trnslt.lcod_lbl_request;
      requestIcon = const Icon(
        Icons.post_add_outlined,
        color: iconColor5,
      );
      selectedColor = iconColor5;
      selectedBackground = color5Background;
    }
    if (_currentRequestType == 'lcod_lbl_request_satisfaction') {
      _currentRequestType = trnslt.lcod_lbl_satisfaction;
      requestIcon = const Icon(
        Icons.volunteer_activism_outlined,
        color: iconColor6,
      );
      selectedColor = iconColor6;
      selectedBackground = color6Background;
    }
    if (_currentRequestType == 'lcod_lbl_request_other') {
      _currentRequestType = trnslt.lcod_lbl_other;
      requestIcon = const Icon(
        Icons.feedback_outlined,
        color: iconColor7,
      );
      selectedColor = iconColor7;
      selectedBackground = color7Background;
    }

    return Container(
      decoration: BoxDecoration(
          // border: Border(
          //   left: BorderSide(color: selectedBackground!, width: 5.0),
          //   right: BorderSide(color: selectedBackground!, width: 5.0),
          //   bottom: BorderSide(color: selectedBackground!, width: 5.0),
          //   top: BorderSide(color: selectedBackground!, width: 5.0),
          // ),
          borderRadius: BorderRadius.circular(25),
          color: selectedBackground),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(35),
      // ),
      margin: const EdgeInsets.fromLTRB(5, 4, 5, 4),
      padding: EdgeInsets.all(10),
      // color: selectedBackground, //widget.color ?? mainBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  requestIcon!,
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    _currentRequestType,
                    style: TextStyle(
                        color: selectedColor, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    widget.status
                        ? Icons.update_outlined
                        : Icons.task_alt_outlined,
                    size: 15,
                    color: selectedColor,
                  ),
                  Text(
                    statusText,
                    style: TextStyle(
                        color: selectedColor, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(widget.requestTitle,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.apartmentNumber),
              const Icon(Icons.arrow_right_alt_outlined),
              // IconButton(
              //   onPressed: widget.onTap,
              //   icon: const Icon(
              //     Icons.arrow_right_alt_outlined,
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
