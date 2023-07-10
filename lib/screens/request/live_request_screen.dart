import 'package:demo_publicarea/screens/statement/payment_select_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_request_card.dart';
import 'package:flutter/material.dart';

class LiveRequestScreen extends StatefulWidget {
  static String routeName = '/liverequest';

  const LiveRequestScreen({Key? key}) : super(key: key);

  @override
  State<LiveRequestScreen> createState() => _LiveRequestScreenState();
}

class _LiveRequestScreenState extends State<LiveRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Taleplerim'),
            backgroundColor: mainBackgroundColor,
          ),
          body: Container(
            color: backgroundColor,
            padding: const EdgeInsets.all(14),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomRequestCard(
                      requestType: 'Öneri',
                      requestExplanation: 'Şikayet açıklaması burada bulunacak',
                      apartmentNumber: '45/A-7',
                      status: true,
                      onTap: () {}),
                  CustomRequestCard(
                      requestType: 'Öneri',
                      requestExplanation: 'Şikayet açıklaması burada bulunacak',
                      apartmentNumber: '45/A-7',
                      status: true,
                      onTap: () {}),
                  CustomRequestCard(
                      requestType: 'Öneri',
                      requestExplanation: 'Şikayet açıklaması burada bulunacak',
                      apartmentNumber: '45/A-7',
                      status: true,
                      onTap: () {}),
                  CustomRequestCard(
                      requestType: 'Öneri',
                      requestExplanation: 'Şikayet açıklaması burada bulunacak',
                      apartmentNumber: '45/A-7',
                      status: false,
                      onTap: () {}),
                  CustomRequestCard(
                      requestType: 'Öneri',
                      requestExplanation: 'Şikayet açıklaması burada bulunacak',
                      apartmentNumber: '45/A-7',
                      status: false,
                      onTap: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
