import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/request/create_request_screen.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_text_block.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class CustomEmptyRequest extends StatelessWidget {
  const CustomEmptyRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    var trnslt = AppLocalizations.of(context)!;
    return Column(children: [
      const SizedBox(
        height: 80,
      ),
      Image.asset('assets/images/rafiki.png'),
      const SizedBox(height: 25),
      CustomTextBlock(
          maintext: trnslt.lcod_lbl_no_complete_request,
          subtext: trnslt.lcod_lbl_new_request_article),
      const SizedBox(
        height: 30,
      ),
      CustomMainButton(
        edgeInsets: const EdgeInsets.symmetric(horizontal: 55),
        onTap: () {
          PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
            context,
            settings: RouteSettings(arguments: {
              'apartmentId': userProvider.currentUser.apartmentId,
              'userUid': userProvider.currentUser.uid
            }, name: CreateRequestScreen.routeName),
            screen: const CreateRequestScreen(),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        text: trnslt.lcod_lbl_new_request,
        icon: Icons.add,
      ),
    ]);
  }
}
