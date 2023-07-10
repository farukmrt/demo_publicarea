import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkCardNumber(String cardNumber) async {
  //başta eslesme degerimiz olumsuz veriliyor.
  bool isMatched = false;

  try {
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection('cards')
        .where('cardNumber', isEqualTo: cardNumber)
        .get();

    if (data == cardNumber) {
      isMatched = true;
    }
  } catch (e) {
    print('Hata: $e');
  }
  return isMatched;
}






// class CardCheckMethods {
//   final _cardCheck = FirebaseFirestore.instance.collection('cards');

//   Future<bool> checkCardNumber(String cardNumber) async {
//     bool isMatched = false;

//     return isMatched;
//   }
// }
