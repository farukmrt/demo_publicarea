import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_subtitle.dart';
import 'package:demo_publicarea/widgets/custom_title.dart';
import 'package:flutter/material.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({Key? key}) : super(key: key);

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Column(
            children: const [
              CustomTitle(mainTitle: 'Hesap Özeti'),
              CustomSubtitle(
                title: 'Ödenmemişler',
                subtitle: 'hill tower',
              ),
              CustomTitle(mainTitle: 'sdg')
            ],
          ),
        ),
      ),
    );
    // return Container(
    //   color: white,
    //   child: SafeArea(
    //       child: Column(
    //     children: [
    //       CustomTitle(MainTitle: 'Hesap Özeti'),
    //     ],
    //   )),
    // );
  }
}
