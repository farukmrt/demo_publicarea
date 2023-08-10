import 'package:flutter/material.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';

class CustomRequestCard extends StatefulWidget {
  final String requestType;
  final String requestTitle;
  final String apartmentNumber;
  final bool status;
  final VoidCallback onTap;

  const CustomRequestCard({
    required this.requestType,
    required this.requestTitle,
    required this.apartmentNumber,
    required this.status,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomRequestCard> createState() => _CustomRequestCardState();
}

class _CustomRequestCardState extends State<CustomRequestCard> {
  String _currentRequestType = '';
  Icon? requestIcon;
  Color? selectedColor;

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
    }

    if (_currentRequestType == 'lcod_lbl_request_question') {
      _currentRequestType = trnslt.lcod_lbl_request_question;
      requestIcon = const Icon(
        Icons.contact_support_outlined,
        color: iconColor2,
      );
      selectedColor = iconColor2;
    }
    if (_currentRequestType == 'lcod_lbl_request_suggestion') {
      _currentRequestType = trnslt.lcod_lbl_request_suggestion;
      requestIcon = const Icon(
        Icons.edit_note_outlined,
        color: iconColor3,
      );
      selectedColor = iconColor3;
    }
    if (_currentRequestType == 'lcod_lbl_request_complaint') {
      _currentRequestType = trnslt.lcod_lbl_request_complaint;
      requestIcon = const Icon(
        Icons.do_not_disturb_on_outlined,
        color: iconColor4,
      );
      selectedColor = iconColor4;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.fromLTRB(5, 4, 5, 4),
      color: mainBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  requestIcon!,
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    _currentRequestType,
                    style: TextStyle(
                        color: selectedColor, fontWeight: FontWeight.w600),
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
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    statusText,
                    style: TextStyle(
                        color: selectedColor, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Text(widget.requestTitle),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.apartmentNumber),
              IconButton(
                onPressed: widget.onTap,
                icon: const Icon(Icons.arrow_right_alt_outlined),
              )
            ],
          )
        ]),
      ),
    );
  }
}
