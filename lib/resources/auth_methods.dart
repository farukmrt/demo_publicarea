// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo_publicarea/providers/user_providers.dart';
// import 'package:demo_publicarea/utils/utils.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:demo_publicarea/models/user.dart' as model;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AuthMethods {
//   final _userRef = FirebaseFirestore.instance.collection('users');
//   final _auth = FirebaseAuth.instance;

//   Future<Map<String, dynamic>?> getCurrentUser(String? uid) async {
//     if (uid != null) {
//       final snap = await _userRef.doc(uid).get();
//       return snap.data();
//     }
//     return null;
//   }

//   Future<bool> signUpUser(
//     BuildContext context,
//     String email,
//     String username,
//     String password,
//     String name,
//     String surname,
//     String building,
//     String imageUrl,
//   ) async {
//     bool res = false;
//     bool usernameExists = await checkUsernameExists(username);
//     if (usernameExists) {
//       showSnackBar(context, 'Bu kullanıcı adı zaten kullanılıyor.');
//       return false;
//     }
//     try {
//       UserCredential cred = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       if (cred.user != null) {
//         model.UserModel user = model.UserModel(
//           surname: surname.trim(),
//           name: name.trim(),
//           username: username.trim(),
//           email: email.trim(),
//           building: building.trim(),
//           uid: cred.user!.uid,
//           apartmentId: '',
//           buildingId: '',
//           imageUrl: imageUrl.trim(),

//           // apartmentId: null,
//           // buildingId: null,
//         );
//         await _userRef.doc(cred.user!.uid).set(user.toMap());

//         Provider.of<UserProvider>(context, listen: false).setUser(user);
//         res = true;
//       }
//     } on FirebaseAuthException catch (e) {
//       showSnackBar(context, e.message!);
//       //print(e.message!);
//       // res = false;
//     }
//     return res;
//   }

//   Future<bool> loginUser(
//     BuildContext context,
//     String email,
//     String password,
//   ) async {
//     bool res = false;
//     try {
//       UserCredential cred = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       if (cred.user != null) {
//         Provider.of<UserProvider>(context, listen: false).setUser(
//           model.UserModel.fromMap(await getCurrentUser(cred.user!.uid) ?? {}),
//         );
//         res = true;
//       }
//     } on FirebaseAuthException catch (e) {
//       showSnackBar(context, e.message!);
//       //print(e.message!);
//       // res = false;
//     }
//     return res;
//   }

//   // Future<bool> signOut(
//   //   BuildContext context,
//   // ) async {
//   //   bool res = true;
//   //   await FirebaseAuth.instance.signOut();
//   //   bool res = false;
//   // }
//   Future<bool> checkUsernameExists(String username) async {
//     try {
//       final querySnapshot =
//           await _userRef.where('username', isEqualTo: username).get();
//       return querySnapshot.docs.isNotEmpty;
//     } catch (e) {
//       // Hata durumu ele alınabilir
//       return true; // Varsayılan olarak true döndürüldü
//     }
//   }

//   Future<String> updatePP(String uid, String imageUrl) async {
//     try {
//       // users koleksiyonunda uid değeri ile eşleşen belgeleri sorgula
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .where('uid', isEqualTo: uid)
//           .get();

//       // Belgeyi referans al
//       DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

//       // Belgedeki image_url alanını güncelle
//       await documentSnapshot.reference.update({'imageUrl': imageUrl});

//       return imageUrl;
//     } catch (e) {
//       print("Profil resmi güncellenirken bir hata oluştu: $e");
//       throw Exception("Profil resmi güncellenirken bir hata oluştu.");
//     }
//   }
// }


// import 'package:demo_publicarea/providers/user_providers.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:demo_publicarea/models/user.dart' as model;

// class AuthMethods {
//   final _userRef = FirebaseFirestore.instance.collection('users');
//   final _auth = FirebaseAuth.instance;

//   Future<Map<String, dynamic>?> getCurrentUser(String? uid) async {
//     if (uid != null) {
//       final snap = await _userRef.doc(uid).get();
//       return snap.data();
//     }
//     return null;
//   }

//   Future<bool> signUpUser(
//     BuildContext context,
//     String email,
//     String username,
//     String password,
//     String name,
//     String surname,
//     String building,
//     String imageUrl,
//   ) async {
//     bool res = false;
//     bool usernameExists = await checkUsernameExists(username);
//     if (usernameExists) {
//       showSnackBar(context, 'Bu kullanıcı adı zaten kullanılıyor.');
//       return false;
//     }
//     try {
//       UserCredential cred = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       if (cred.user != null) {
//         model.User user = model.User(
//           surname: surname.trim(),
//           name: name.trim(),
//           username: username.trim(),
//           email: email.trim(),
//           building: building.trim(),
//           uid: cred.user!.uid,
//           apartmentId: '',
//           buildingId: '',
//           imageUrl: imageUrl.trim(),
//         );
//         await _userRef.doc(cred.user!.uid).set(user.toMap());

//         Provider.of<UserProvider>(context, listen: false).setUser(user);
//         res = true;
//       }
//     } on FirebaseAuthException catch (e) {
//       showSnackBar(context, e.message!);
//     }
//     return res;
//   }

//   Future<bool> loginUser(
//     BuildContext context,
//     String email,
//     String password,
//   ) async {
//     bool res = false;
//     try {
//       UserCredential cred = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       if (cred.user != null) {
//         Provider.of<UserProvider>(context, listen: false).setUser(
//           model.User.fromMap(await getCurrentUser(cred.user!.uid) ?? {}),
//         );
//         res = true;
//       }
//     } on FirebaseAuthException catch (e) {
//       showSnackBar(context, e.message!);
//     }
//     return res;
//   }

//   Future<bool> checkUsernameExists(String username) async {
//     try {
//       final querySnapshot =
//           await _userRef.where('username', isEqualTo: username).get();
//       return querySnapshot.docs.isNotEmpty;
//     } catch (e) {
//       // Hata durumu ele alınabilir
//       return true; // Varsayılan olarak true döndürüldü
//     }
//   }

//   void showSnackBar(BuildContext context, String message) {
//     final snackBar = SnackBar(
//       content: Text(message),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
