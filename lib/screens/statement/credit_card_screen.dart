import 'package:demo_publicarea/providers/payment_provider.dart';
import 'package:demo_publicarea/resources/auth_methods.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CreditCardScreen extends StatefulWidget {
  static String routeName = '/creditCard';

  const CreditCardScreen({Key? key}) : super(key: key);

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   // final TextEditingController _cardNumberController = TextEditingController();
//   // final TextEditingController _expiryDateController = TextEditingController();
//   // final TextEditingController _cardHolderNameController = TextEditingController();
//   // final TextEditingController _cvvCodeController = TextEditingController();
//   // //final TextEditingController _emailController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: AppBar(title: const Text('Ödeme')),
//       body: Column(children: [
//         CreditCardWidget(
//             cardNumber: cardNumber,
//             expiryDate: expiryDate,
//             cardHolderName: cardHolderName,
//             cvvCode: cvvCode,
//             showBackView: true,
//             onCreditCardWidgetChange: (CreditCardBrand CardBrand) {}),
//         // CreditCardWidget(
//         //     cardNumber: _cardNumberController,
//         //     expiryDate: _expiryDateController,
//         //     cardHolderName: _cardHolderNameController,
//         //     cvvCode: _cvvCodeController,
//         //     showBackView: true,
//         //     onCreditCardWidgetChange: (CreditCardBrand cardBrand){}),
//         // CustomTextField(controller: ,labelText: 'Kart Numarası'),
//         // Row(
//         //   children: [CustomTextField(controller: ,labelText: 'Son Kullanma Tarihi',), CustomTextField('CVV')],
//         // ),
//         // CustomTextField(controller: ,labelText: 'Kart Sahibi'),
//         CreditCardForm(
//           formKey: formKey,
//           obscureCvv: true,
//           obscureNumber: true,
//           cardNumber: cardNumber,
//           cvvCode: cvvCode,
//           isHolderNameVisible: true,
//           isCardNumberVisible: true,
//           isExpiryDateVisible: true,
//           cardHolderName: cardHolderName,
//           expiryDate: expiryDate,
//           themeColor: Colors.blue,
//           textColor: Colors.white,
//           cardNumberDecoration: InputDecoration(
//             labelText: 'Card Number',
//             hintText: 'XXXX XXXX XXXX XXXX',
//             hintStyle: const TextStyle(color: Colors.white),
//             labelStyle: const TextStyle(color: Colors.white),
//             focusedBorder: border,
//             enabledBorder: border,
//           ),
//           expiryDateDecoration: InputDecoration(
//             hintStyle: const TextStyle(color: Colors.white),
//             labelStyle: const TextStyle(color: Colors.white),
//             focusedBorder: border,
//             enabledBorder: border,
//             labelText: 'Expired Date',
//             hintText: 'XX/XX',
//           ),
//           cvvCodeDecoration: InputDecoration(
//             hintStyle: const TextStyle(color: Colors.white),
//             labelStyle: const TextStyle(color: Colors.white),
//             focusedBorder: border,
//             enabledBorder: border,
//             labelText: 'CVV',
//             hintText: 'XXX',
//           ),
//           cardHolderDecoration: InputDecoration(
//             hintStyle: const TextStyle(color: Colors.white),
//             labelStyle: const TextStyle(color: Colors.white),
//             focusedBorder: border,
//             enabledBorder: border,
//             labelText: 'Card Holder',
//           ),
//           onCreditCardModelChange: onCreditCardModelChange,
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//       ]),
//     ));
//   }
// }

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  OutlineInputBorder? border;
  TextEditingController bankName = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: buttonColor,
        width: 2.0,
      ),
    );
    bankName = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // MaterialApp(
        //   title: 'Flutter Credit Card View Demo',
        //   debugShowCheckedModeBanner: false,
        //   theme: ThemeData(
        //     primarySwatch: Colors.grey,
        //   ),
        Scaffold(
      appBar: AppBar(
        title: const Text('Kart Ekranı'),
        backgroundColor: mainBackgroundColor,
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: ExactAssetImage('assets/images/bg.png'),
          //   fit: BoxFit.fill,
          // ),
          color: backgroundColor,
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              CreditCardWidget(
                glassmorphismConfig: Glassmorphism.defaultConfig(),
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                bankName: bankName.text,
                //kart cevresindeki border
                frontCardBorder: Border.all(color: buttonColor),
                backCardBorder: Border.all(color: buttonColor),
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                //cardBgColor: Colors.red,
                backgroundImage: 'assets/images/card_bg.png',
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                customCardTypeIcons: <CustomCardTypeIcon>[
                  CustomCardTypeIcon(
                    cardType: CardType.mastercard,
                    cardImage: Image.asset(
                      'assets/images/mastercard.png',
                      height: 48,
                      width: 48,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 17, right: 17, top: 10),
                        child: TextFormField(
                          controller: bankName,
                          style: const TextStyle(color: mytextcolor),
                          onEditingComplete: (() => setState(() {})),
                          decoration: InputDecoration(
                            labelText: 'Banka İsmi',
                            hintText: '... Bank',
                            hintStyle: const TextStyle(color: buttonColor),
                            labelStyle: const TextStyle(color: buttonColor),
                            focusedBorder: border,
                            enabledBorder: border,
                          ),
                        ),
                      ),
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: buttonColor,
                        textColor: mytextcolor,
                        cardNumberDecoration: InputDecoration(
                          labelText: 'Kart Numarası',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          hintStyle: const TextStyle(color: buttonColor),
                          labelStyle: const TextStyle(color: buttonColor),
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        expiryDateDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: buttonColor),
                          labelStyle: const TextStyle(color: buttonColor),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Son Kullanma Tarihi',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: buttonColor),
                          labelStyle: const TextStyle(color: buttonColor),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: buttonColor),
                          labelStyle: const TextStyle(color: buttonColor),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Kart Sahibi',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      CustomMainButton(
                        onTap: () {
                          checkCardNumber(cardNumber);
                          // cardInfo.carnumber
                          // loading true;
                          // result = await cardprovider.completePayment(cardInfo, amount)
                          // loading false;
                          // result göster
                          // ödeme başarılı ise öedenmişler sayfasına gönnder
                        },
                        text: 'Ödemeyi Onayla ',
                        edgeInsets: const EdgeInsets.symmetric(horizontal: 18),
                      )
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Container(
                      //       margin: const EdgeInsets.symmetric(
                      //           horizontal: 16, vertical: 8),

                      //       // decoration: BoxDecoration(
                      //       //   gradient: const LinearGradient(
                      //       //     colors: <Color>[
                      //       //       buttonColor,
                      //       //       secondaryBackgroundColor,
                      //       //     ],
                      //       //     begin: Alignment.topCenter,
                      //       //     end: Alignment.bottomCenter,
                      //       //   ),
                      //       //   borderRadius: BorderRadius.circular(8),
                      //       // ),
                      //       padding: const EdgeInsets.symmetric(vertical: 15),
                      //       width: double.infinity,
                      //       alignment: Alignment.center,

                      //       child: CustomMainButton(
                      //         onTap: () {},
                      //         text: 'Ödemeyi Onayla',
                      //         edgeInsets: const EdgeInsets.symmetric(vertical: 8),
                      //       )

                      //       // const Text(
                      //       //   'Ödemeyi Onayla',
                      //       //   style: TextStyle(
                      //       //     color: Colors.black,
                      //       //     fontFamily: 'halter',
                      //       //     fontSize: 14,
                      //       //     package: 'flutter_credit_card',
                      //       //   ),
                      //       // ),
                      //       ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _onValidate() {
  //   if (formKey.currentState!.validate()) {
  //     _showValidDialog(context, "Valid", "Your card successfully valid !!!");
  //   } else {
  //     _showValidDialog(context, "Not Valid", "Try Again !!!");
  //   }
  // }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  _showValidDialog(
    BuildContext context,
    String title,
    String content,
  ) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(title),
          content: Text(content),
        );
      },
    );
  }
}
