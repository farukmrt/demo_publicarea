import 'package:demo_publicarea/models/description.dart';
import 'package:demo_publicarea/models/user.dart';
import 'package:demo_publicarea/providers/description_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_button.dart';
import 'package:demo_publicarea/widgets/custom_column_button.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    // DescriptionProvider descriptionProvider =
    //     Provider.of<DescriptionProvider>(context);
    // for (int i = 0; i < 3; i++) {
    //   Description description = Description(
    //     titlee: 'Duyuru Başlığı $i',
    //     subtitlee: 'Duyuru Alt Başlığı $i',
    //   );
    //   descriptionProvider.addDescription(description);
    // }
    UserProvider userProvider = Provider.of<UserProvider>(context);
    String nameSurname =
        '${userProvider.user.name} ${userProvider.user.surname}';
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screenHeight / 4.95,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(45),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: Image.asset(
                    'assets/images/oval.png',
                    scale: 1,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nameSurname,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: mainBackgroundColor),
                                  ),
                                  const Text(
                                    'Hill Tower Göksu',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: mainBackgroundColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: CircleAvatar(
                                foregroundImage:
                                    AssetImage('assets/images/pp.png'),
                                radius: 35,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Borcunuz',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  Text(
                                    'amountot',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CustomCIconbutton(
                    title: 'Ödeme\nYap',
                    icon: Icons.wallet_outlined,
                    ontap: () {}),
                CustomCIconbutton(
                    title: 'Ödeme\nYap',
                    icon: Icons.wallet_outlined,
                    ontap: () {}),
                CustomCIconbutton(
                    title: 'Ödeme\nYap',
                    icon: Icons.wallet_outlined,
                    ontap: () {}),
                CustomCIconbutton(
                    title: 'Ödeme\nYap',
                    icon: Icons.wallet_outlined,
                    ontap: () {}),
                CustomCIconbutton(
                    title: 'Ödeme\nYap',
                    icon: Icons.wallet_outlined,
                    ontap: () {}),
              ],
            ),
          ),
          Expanded(
            child: Consumer<DescriptionProvider>(
              builder: (context, provider, _) {
                List<Description> descriptions = provider.description;

                return ListView.builder(
                  itemCount: descriptions.length,
                  itemBuilder: (context, index) {
                    Description description = descriptions[index];
                    return CustomListItem(
                      title: description.titlee,
                      subtitle: description.subtitlee,
                      trailing: const Icon(Icons.arrow_forward_ios),
                      leading: const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/notice.png'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}










/*
Expanded(
                child: Consumer<DescriptionProvider>(
                  builder: (context, provider, _) {
                    List<Description> descriptions = provider.description;
                    var uuid = Uuid(); // Uuid sınıfını oluşturun

                    return ListView.builder(
                      itemCount: descriptions.length,
                      itemBuilder: (context, index) {
                        Description description = descriptions[index];
                        String uniqueKey =
                            uuid.v4(); // Benzersiz bir kimlik oluşturun
                        return Dismissible(
                          key: Key(uniqueKey),
                          onDismissed: (direction) {
                            provider.removeDescription(description);
                          },
                          background: Container(
                            color: Colors.red,
                            child: Icon(Icons.delete),
                          ),
                          child: CustomListItem(
                            title: description.titlee,
                            subtitle: description.subtitlee,
                          ),
                        );
                      },
                    );
                  },
                ),
              )
*/