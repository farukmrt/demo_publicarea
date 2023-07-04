import 'package:demo_publicarea/screens/statement/payment_select_screen.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomMainButton(
          edgeInsets: const EdgeInsets.symmetric(vertical: 8),
          onTap: () {
            Navigator.of(context, rootNavigator: false).push(MaterialPageRoute(
                builder: (context) => const PaymentSelectScreen(),
                maintainState: true));
          },
          text: 'ödeme yap'),
    );
  }
}
