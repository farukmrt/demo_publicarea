import 'package:demo_publicarea/screens/request/request_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_dropdownbutton.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class CreateRequestScreen extends StatefulWidget {
  static String routeName = '/createrequest';

  const CreateRequestScreen({Key? key}) : super(key: key);

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Talep oluştur'),
            backgroundColor: mainBackgroundColor,
          ),
          body: Container(
            color: backgroundColor,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Column(
                  children: [
                    const CustomTextField(
                      labelText: 'Konu',
                    ),
                    const CustomTextField(
                      labelText: 'Daire',
                    ),
                    //DropdownButtonFormField(items:, onChanged: (){})

                    CustomDropdownButton(
                      labelText: 'Talep Tipi',
                      value: selectedValue,
                      items: ['Arıza', 'Soru', 'Öneri', 'Şikayet'],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      },
                    ),
                    // const CustomTextField(
                    //   labelText: 'Talep Tipi',
                    // ),
                    const CustomTextField(
                      labelText: 'Yaşam Alanı Tipi',
                    ),
                    const CustomTextField(
                      labelText: 'Açıklama',
                      minlinee: 5,
                      //maxline: minLine + 1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomMainButton(
                      text: 'Talebi Gönder..',
                      edgeInsets: const EdgeInsets.symmetric(vertical: 25),
                      onTap: () {
                        Navigator.pushNamed(context, RequestScreen.routeName);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
