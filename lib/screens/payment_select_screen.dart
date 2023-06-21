import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';

class PaymentSelectScreen extends StatefulWidget {
  static String routeName = '/paymentSelect';
  const PaymentSelectScreen({Key? key}) : super(key: key);

  @override
  State<PaymentSelectScreen> createState() => _PaymentSelectScreenState();
}

class _PaymentSelectScreenState extends State<PaymentSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: negative,
    );
  }
}
