import 'package:demo_publicarea/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/models/bill.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/models/creditCard.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/providers/payment_provider.dart';
//import 'package:demo_publicarea/widgets/custom_double_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:demo_publicarea/screens/statement/itemized_account_screen.dart';

class CreditCardScreen extends StatefulWidget {
  static String routeName = '/creditCard';
  final Map<String, dynamic> arguments;
  const CreditCardScreen({Key? key, required this.arguments}) : super(key: key);
  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isMatched = false;
  bool isLoading = false;
  String? summary;
  String? amount;
  late List<Bill> selectedBill;
  late List<Bill> selectBill;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String? summary = argument['summary'];
    dynamic selectedBill = argument['selectedBill'];
    //
    String? amount = argument['amount'];
    dynamic selectBill = argument['selectBill'];

    if (summary == null) {
      // && selectedBill == null) {
      summary = amount;
      selectedBill = selectBill;
    } else {
      amount = summary;
      selectBill = selectedBill;
    }
    setState(() {
      this.summary = summary;
      this.selectedBill = selectedBill;
      this.amount = amount;
      this.selectBill = selectBill;
    });
  }

  CreditCard creditCard = CreditCard(
    cardNumber: '',
    expiryDate: '',
    cvv: '',
    holderName: '',
  );

  @override
  void initState() {
    super.initState();
    cardNumber.addListener(_cardControllerListener);
    expiryDate.addListener(_cardControllerListener);
    cvvCode.addListener(_cardControllerListener);
    cardHolderName.addListener(_cardControllerListener);

    _cardControllerListener();

    border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(35),
      borderSide: const BorderSide(
        color: buttonColor,
        width: 2,
      ),
    );
    errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(35),
      borderSide: const BorderSide(
        color: negative,
        width: 2.5,
      ),
    );
  }

  void _cardControllerListener() {
    String cardNumberValue = cardNumber.text;
    String expiryDateValue = expiryDate.text;
    String cvvCodeValue = cvvCode.text;
    String CardHolderNameValue = cardHolderName.text;
    print('Yeni kart numarası: $cardNumberValue');
    print('Yeni tarih: $expiryDateValue');
    print('Yeni cvv: $cvvCodeValue');
    print('Yeni kart sahibi: $CardHolderNameValue');

    setState(() {
      if (cardNumberValue.length >= 18 &&
          expiryDateValue.length == 5 &&
          cvvCodeValue.length > 2 &&
          CardHolderNameValue.isNotEmpty) {
        print('$changing');
        changing = true;
      } else {
        print('$changing');

        changing = false;
      }
    });
  }

  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController expiryDate = TextEditingController();
  final TextEditingController cvvCode = TextEditingController();
  final TextEditingController cardHolderName = TextEditingController();

  bool isCvvFocused = false;
  OutlineInputBorder? border;
  OutlineInputBorder? errorBorder;

  bool changing = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var trnslt = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(trnslt.lcod_lbl_card_screen),
        backgroundColor: mainBackgroundColor,
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
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
                    cardNumber: cardNumber.text,
                    expiryDate: expiryDate.text,
                    cardHolderName: cardHolderName.text,
                    cvvCode: cvvCode.text,
                    frontCardBorder: Border.all(color: buttonColor),
                    backCardBorder: Border.all(color: buttonColor),
                    showBackView: isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    isHolderNameVisible: true,
                    backgroundImage: 'assets/images/card_bg.png',
                    isSwipeGestureEnabled: true,
                    onCreditCardWidgetChange:
                        (CreditCardBrand creditCardBrand) {},
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 40,
                                  right: 40,
                                ),
                                child: CustomIconbutton(
                                  //title: trnslt.lcod_lbl_selected_amount,
                                  color: positive.shade100,
                                  textSize: 20,
                                  title:
                                      '${trnslt.lcod_lbl_selected_amount} $summary',
                                  icon: Icons.subdirectory_arrow_right_outlined,

                                  size: 35,
                                ),
                              ),
                            ),
                            CreditCardForm(
                              formKey: formKey,
                              obscureCvv: true,
                              obscureNumber: true,
                              cardNumber: cardNumber.text,
                              cardNumberValidator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.characters.length < 18) {
                                  return trnslt.lcod_lbl_control_card_number;
                                }
                                return null;
                              },
                              cvvCode: cvvCode.text,
                              cvvValidator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.characters.length <= 2) {
                                  return trnslt.lcod_lbl_control_cvv_code;
                                }
                                return null;
                              },
                              isHolderNameVisible: true,
                              isCardNumberVisible: true,
                              isExpiryDateVisible: true,
                              cardHolderName: cardHolderName.text,
                              cardHolderValidator: (value) {
                                if (value == null || value.isEmpty) {
                                  return trnslt.lcod_lbl_control_double_name;
                                }
                                return null;
                              },
                              expiryDate: expiryDate.text,
                              expiryDateValidator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.characters.length != 5) {
                                  return trnslt.lcod_lbl_control_valid_thru;
                                }
                                return null;
                              },
                              themeColor: buttonColor,
                              textColor: mytextcolor,
                              cardNumberDecoration: InputDecoration(
                                labelText: trnslt.lcod_lbl_card_number,
                                hintText: 'XXXX XXXX XXXX XXXX',
                                hintStyle: const TextStyle(color: buttonColor),
                                labelStyle: const TextStyle(color: buttonColor),
                                focusedBorder: border,
                                enabledBorder: border,
                                errorBorder: errorBorder,
                                focusedErrorBorder: errorBorder,
                              ),
                              expiryDateDecoration: InputDecoration(
                                hintStyle: const TextStyle(color: buttonColor),
                                labelStyle: const TextStyle(color: buttonColor),
                                focusedBorder: border,
                                enabledBorder: border,
                                labelText: trnslt.lcod_lbl_expiration,
                                hintText: 'XX/XX',
                                errorBorder: errorBorder,
                                focusedErrorBorder: errorBorder,
                              ),
                              cvvCodeDecoration: InputDecoration(
                                hintStyle: const TextStyle(color: buttonColor),
                                labelStyle: const TextStyle(color: buttonColor),
                                focusedBorder: border,
                                enabledBorder: border,
                                labelText: 'CVV',
                                hintText: 'XXX',
                                errorBorder: errorBorder,
                                focusedErrorBorder: errorBorder,
                              ),
                              cardHolderDecoration: InputDecoration(
                                hintStyle: const TextStyle(color: buttonColor),
                                labelStyle: const TextStyle(color: buttonColor),
                                focusedBorder: border,
                                enabledBorder: border,
                                errorBorder: errorBorder,
                                focusedErrorBorder: errorBorder,
                                labelText: trnslt.lcod_lbl_card_holder,
                              ),
                              onCreditCardModelChange: onCreditCardModelChange,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            CustomMainButton(
                              onTap: () async {
                                setState(() {
                                  changing;
                                });
                                if (formKey.currentState!.validate() &&
                                    changing) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  isMatched =
                                      await Provider.of<PaymentProvider>(
                                              context,
                                              listen: false)
                                          .checkPayment(
                                    cardNumber.text,
                                    cardHolderName.text,
                                    cvvCode.text,
                                    expiryDate.text,
                                  );
                                  if (isMatched) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            trnslt.lcod_lbl_payment_successful),
                                      ),
                                    );

                                    await Provider.of<PaymentProvider>(context,
                                            listen: false)
                                        .updateBillPaidStatus(selectedBill);

                                    PersistentNavBarNavigator
                                        .pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(
                                          name:
                                              ItemizedAccountScreen.routeName),
                                      screen: const ItemizedAccountScreen(),
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(trnslt
                                            .lcod_lbl_wrong_card_information),
                                      ),
                                    );
                                  }
                                }
                              },
                              color: changing
                                  ? primaryColor
                                  : primaryColor.withOpacity(0.5),
                              text: trnslt.lcod_lbl_confirm_payment,
                              edgeInsets:
                                  const EdgeInsets.symmetric(horizontal: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Center(
              child: LoadingAnimationWidget.dotsTriangle(
                  color: positive, size: size.width / 3),
            ),
        ],
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber.text = creditCardModel.cardNumber;
      expiryDate.text = creditCardModel.expiryDate;
      cardHolderName.text = creditCardModel.cardHolderName;
      cvvCode.text = creditCardModel.cvvCode;
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
