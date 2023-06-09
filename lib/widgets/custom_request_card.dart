import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomRequestCard extends StatefulWidget {
  final String requestType;
  final String requestExplanation;
  final String apartmentNumber;
  final bool status;
  final VoidCallback onTap;

  const CustomRequestCard({
    required this.requestType,
    required this.requestExplanation,
    required this.apartmentNumber,
    required this.status,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomRequestCard> createState() => _CustomRequestCardState();
}

class _CustomRequestCardState extends State<CustomRequestCard> {
  @override
  Widget build(BuildContext context) {
    String statusText = widget.status ? 'Beklemede' : 'Sonuçlandı';
    Icon statusIcon = (widget.status
        ? const Icon(Icons.update_outlined)
        : const Icon(Icons.task_alt_outlined));

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
              Text(widget.requestType),
              Row(
                children: [
                  Icon(
                    widget.status
                        ? Icons.update_outlined
                        : Icons.task_alt_outlined,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(statusText),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Text(widget.requestExplanation),
          // SizedBox(
          //   height: 0,
          // ),
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
