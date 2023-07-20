import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// //DUYURU OLUŞTURMA
// class MyWidgetScreen extends StatefulWidget {
//   const MyWidgetScreen({Key? key}) : super(key: key);

//   @override
//   _MyWidgetScreenState createState() => _MyWidgetScreenState();
// }

// class _MyWidgetScreenState extends State<MyWidgetScreen> {
//   TextEditingController buildIdController = TextEditingController();
//   TextEditingController subtitleController = TextEditingController();
//   TextEditingController titleController = TextEditingController();

//   var ide = 100; // Declare ide as an instance variable
// //veri girisi yapilirken guncel degere göre ide degiskeninin degistirilmesi lazım
//   Future<void> sendDataToFirestore() async {
//     try {
//       final CollectionReference collectionRef =
//           FirebaseFirestore.instance.collection('announcements');

//       Timestamp selectedDate = Timestamp.now(); // Get the current timestamp

//       await collectionRef.add({
//         'build_id': buildIdController.text,
//         'subtitle': subtitleController.text,
//         'title': titleController.text,
//         'date': selectedDate,
//         'id': ide.toString(),
//       });
//       print('Veriler Firestore\'a başarıyla gönderildi.');
//     } catch (e) {
//       print('Firestore\'a verileri gönderirken hata oluştu: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Widget Screen'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: buildIdController,
//               decoration: InputDecoration(
//                 labelText: 'Build ID',
//               ),
//             ),
//             TextField(
//               controller: subtitleController,
//               decoration: InputDecoration(
//                 labelText: 'Subtitle',
//               ),
//             ),
//             TextField(
//               controller: titleController,
//               decoration: InputDecoration(
//                 labelText: 'Title',
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   ide++; // Increment the value of ide
//                 });
//                 sendDataToFirestore();
//               },
//               child: Text('Verileri Firestore\'a Gönder'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//KREDİ KARTI EKLEME
class MyWidgetScreen extends StatefulWidget {
  const MyWidgetScreen({Key? key}) : super(key: key);

  @override
  _MyWidgetScreenState createState() => _MyWidgetScreenState();
}

class _MyWidgetScreenState extends State<MyWidgetScreen> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cvvCodeController = TextEditingController();

  var ide = 6;
//veri girisi yapilirken guncel degere göre ide degiskeninin degistirilmesi lazım
  Future<void> sendDataToFirestore() async {
    try {
      final CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('cards');

      Timestamp selectedDate = Timestamp.now(); // Get the current timestamp

      await collectionRef.add({
        'cardNumber': cardNumberController.text,
        'expiryDate': expiryDateController.text,
        'cardHolderName': cardHolderNameController.text,
        'cvvCode': cvvCodeController.text,
        'cardId': ide.toString(),
      });
      print('Veriler Firestore\'a başarıyla gönderildi.');
    } catch (e) {
      print('Firestore\'a verileri gönderirken hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Widget Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cardNumberController,
              decoration: const InputDecoration(
                labelText: 'cardNumber',
              ),
            ),
            TextField(
              controller: expiryDateController,
              decoration: const InputDecoration(
                labelText: 'expiryDate',
              ),
            ),
            TextField(
              controller: cardHolderNameController,
              decoration: const InputDecoration(
                labelText: 'cardHolderName',
              ),
            ),
            TextField(
              controller: cvvCodeController,
              decoration: const InputDecoration(
                labelText: 'cvvCode',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  ide++; // Increment the value of ide
                });
                sendDataToFirestore();
              },
              child: const Text('Verileri Firestore\'a Gönder'),
            ),
          ],
        ),
      ),
    );
  }
}
