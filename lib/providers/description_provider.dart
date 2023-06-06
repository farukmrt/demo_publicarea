import 'package:demo_publicarea/models/description.dart';
import 'package:flutter/material.dart';

class DescriptionProvider with ChangeNotifier {
  List<Description> descriptions = const [
    Description(
        titlee: 'Duyuru Başlığı1', subtitlee: 'Duyuru alt başlığı şalsdkdsaf'),
    Description(
        titlee: 'Duyuru Başlığı2', subtitlee: 'Duyuru alt başlığı şalsdkdsaf'),
    Description(
        titlee: 'Duyuru Başlığı3', subtitlee: 'Duyuru alt başlığı şalsdkdsaf'),
    Description(
        titlee: 'Duyuru Başlığı4', subtitlee: 'Duyuru alt başlığı şalsdkdsaf'),
    Description(
        titlee: 'Duyuru Başlığı5', subtitlee: 'Duyuru alt başlığı şalsdkdsaf'),
    Description(
        titlee: 'Duyuru Başlığı6', subtitlee: 'Duyuru alt başlığı şalsdkdsaf'),
    Description(
        titlee: 'Duyuru Başlığı7', subtitlee: 'Duyuru alt başlığı şalsdkdsaf'),
    Description(
        titlee: 'Duyuru Başlığı8', subtitlee: 'Duyuru alt başlığı şalsdkdsaf'),
    Description(
        titlee: 'Duyuru Başlığı9', subtitlee: 'Duyuru alt başlığı şalsdkdsaf'),
    Description(
        titlee: 'Duyuru Başlığı10', subtitlee: 'Duyuru alt başlığı şalsdkdsaf'),
    Description(
        titlee: 'Duyuru Başlığı11', subtitlee: 'Duyuru alt başlığı şalsdkdsaf'),
  ];

  List<Description> get description => descriptions;

  void addDescription(Description description) {
    descriptions.add(description);
    notifyListeners();
  }

  void removeDescription(Description description) {
    descriptions.remove(description);
    notifyListeners();
  }
}


// DescriptionProvider descriptionProvider =
//         Provider.of<DescriptionProvider>(context);
//     for (int i = 0; i < 3; i++) {
//       Description description = Description(
//         titlee: 'Duyuru Başlığı $i',
//         subtitlee: 'Duyuru Alt Başlığı $i',
//       );
//       descriptionProvider.addDescription(description
