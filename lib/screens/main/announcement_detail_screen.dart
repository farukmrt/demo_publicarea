import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/models/announcement.dart';
import 'package:demo_publicarea/widgets/custom_title.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_listitem_big.dart';
import 'package:demo_publicarea/providers/announcement_provider.dart';

class AnnouncementDetailScreen extends StatefulWidget {
  static String routeName = '/announcementDetail';

  const AnnouncementDetailScreen({Key? key}) : super(key: key);

  @override
  State<AnnouncementDetailScreen> createState() =>
      _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends State<AnnouncementDetailScreen> {
  late String announcementId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    announcementId = ModalRoute.of(context)!.settings.arguments as String;
  }

  @override
  Widget build(BuildContext context) {
    AnnouncementProvider annoProvider =
        Provider.of<AnnouncementProvider>(context, listen: false);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    var trnslt = AppLocalizations.of(context)!;

    return StreamBuilder<Announcement?>(
      stream: annoProvider.fetchAnnouncementDetails(announcementId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text(userProvider.currentUser.building),
              backgroundColor: mainBackgroundColor,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(userProvider.currentUser.building),
              backgroundColor: mainBackgroundColor,
            ),
            body: Center(
              child:
                  Text('${trnslt.lcod_lbl_error_snapshot} ${snapshot.error}'),
            ),
          );
        } else {
          Announcement? announcement = snapshot.data;
          if (announcement == null) {
            return Scaffold(
              appBar: AppBar(
                title: Text(userProvider.currentUser.building),
                backgroundColor: mainBackgroundColor,
              ),
              body: Center(
                child: Text(trnslt.lcod_lbl_announcement_not_found),
              ),
            );
          }

          return Container(
            color: mainBackgroundColor,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(userProvider.currentUser.building),
                  backgroundColor: mainBackgroundColor,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTitle(
                        mainTitle:
                            NoyaFormatter.generateDetail(announcement.date),
                      ),
                      CustomBigListItem(
                        image: announcement.imageUrl,
                        title: announcement.title,
                        subtitle: trnslt.lcod_lbl_dear_username_surname(
                            userProvider.currentUser.name,
                            userProvider.currentUser.surname),
                        text: announcement.subtitle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
