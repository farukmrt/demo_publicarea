// import 'package:demo_publicarea/models/announcement.dart';
// import 'package:demo_publicarea/providers/announcement_provider.dart';
// import 'package:demo_publicarea/providers/user_providers.dart';
// import 'package:demo_publicarea/utils/colors.dart';
// import 'package:demo_publicarea/utils/date_amount_formatter.dart';
// import 'package:demo_publicarea/widgets/custom_listitem_big.dart';
// import 'package:demo_publicarea/widgets/custom_title.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AnAnnouncementScreen extends StatefulWidget {
//   static String routeName = '/anAnnouncement';

//   const AnAnnouncementScreen({Key? key}) : super(key: key);

//   @override
//   State<AnAnnouncementScreen> createState() => _AnAnnouncementScreenState();
// }

// class _AnAnnouncementScreenState extends State<AnAnnouncementScreen> {
//   late String
//       announcementId; // announcementId değerini saklamak için değişken ekle
//   bool isLoading =
//       true; // Duyurunun yüklenip yüklenmediğini takip etmek için isLoading değişkeni eklendi

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     announcementId = ModalRoute.of(context)!.settings.arguments
//         as String; // announcementId değerini al
//     fetchAnnouncement(); // announcementId ile ilgili duyuruyu çek
//   }

//   Future<void> fetchAnnouncement() async {
//     AnnouncementProvider annoProvider =
//         Provider.of<AnnouncementProvider>(context, listen: false);
//     Announcement? announcement =
//         await annoProvider.fetchAnAnnouncement(announcementId);
//     if (announcement != null) {
//       setState(() {
//         annoProvider.announcement = announcement;
//         isLoading =
//             false; // Duyuru başarıyla yüklendiğinde isLoading değerini false yap
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     AnnouncementProvider annoProvider =
//         Provider.of<AnnouncementProvider>(context, listen: false);
//     UserProvider userProvider = Provider.of<UserProvider>(context);

//     if (isLoading) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text(userProvider.user.building),
//           backgroundColor: mainBackgroundColor,
//         ),
//         body: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }

//     return Container(
//       color: mainBackgroundColor,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(userProvider.user.building),
//             backgroundColor: mainBackgroundColor,
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 CustomTitle(
//                     mainTitle: NoyaFormatter.generate(
//                         annoProvider.announcement!.date)),
//                 CustomBigListItem(
//                   title: annoProvider.announcement!.title,
//                   subtitle:
//                       'Sayın ${userProvider.user.name} ${userProvider.user.surname}',
//                   text: annoProvider.announcement!.subtitle,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:demo_publicarea/models/announcement.dart';
import 'package:demo_publicarea/providers/announcement_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_listitem_big.dart';
import 'package:demo_publicarea/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnAnnouncementScreen extends StatefulWidget {
  static String routeName = '/anAnnouncement';

  const AnAnnouncementScreen({Key? key}) : super(key: key);

  @override
  State<AnAnnouncementScreen> createState() => _AnAnnouncementScreenState();
}

class _AnAnnouncementScreenState extends State<AnAnnouncementScreen> {
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

    return StreamBuilder<Announcement?>(
      stream: annoProvider.fetchAnAnnouncement(announcementId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text(userProvider.user.building),
              backgroundColor: mainBackgroundColor,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(userProvider.user.building),
              backgroundColor: mainBackgroundColor,
            ),
            body: Center(
              child: Text('Hata: ${snapshot.error}'),
            ),
          );
        } else {
          Announcement? announcement = snapshot.data;
          if (announcement == null) {
            return Scaffold(
              appBar: AppBar(
                title: Text(userProvider.user.building),
                backgroundColor: mainBackgroundColor,
              ),
              body: Center(
                child: Text('Duyuru bulunamadı.'),
              ),
            );
          }

          return Container(
            color: mainBackgroundColor,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(userProvider.user.building),
                  backgroundColor: mainBackgroundColor,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTitle(
                        mainTitle: NoyaFormatter.generate(announcement.date),
                      ),
                      CustomBigListItem(
                        title: announcement.title,
                        subtitle:
                            'Sayın ${userProvider.user.name} ${userProvider.user.surname}',
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
