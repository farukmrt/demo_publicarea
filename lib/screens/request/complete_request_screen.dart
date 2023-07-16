import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_request_card.dart';
import 'package:flutter/material.dart';

class CompleteRequestScreen extends StatefulWidget {
  static String routeName = '/completerequest';

  const CompleteRequestScreen({Key? key}) : super(key: key);

  @override
  State<CompleteRequestScreen> createState() => _CompleteRequestScreenState();
}

class _CompleteRequestScreenState extends State<CompleteRequestScreen> {
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
