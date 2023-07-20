// import 'dart:async';
// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:demo_publicarea/models/user.dart';

// class UserProvider extends ChangeNotifier {
//   User _user = User(
//     uid: '',
//     email: '',
//     username: '',
//     name: '',
//     surname: '',
//     building: '',
//     apartmentId: '',
//     buildingId: '',
//     imageUrl: '',
//   );

//   User get user => _user;

//   final StreamController<User> _userController = StreamController<User>();
//   Stream<User> get userStream => _userController.stream;

//   void setUser(User user) {
//     _user = user;
//     _userController.add(user); // Yeni veriyi Stream'e ekleyin
//     notifyListeners();
//   }

//   // dispose metoduyla StreamController'ı kapatmayı unutmayın
//   void dispose() {
//     _userController.close();
//     //super.dispose();
//   }
//   // setUser(User user) {
//   //   _user = user;
//   //   notifyListeners();
//   // }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  final StreamController<UserModel> _userController =
      StreamController<UserModel>();
  Stream<UserModel> get userStream =>
      _userController.stream; //.asBroadcastStream();

  UserModel _user = UserModel(
    uid: '',
    email: '',
    username: '',
    name: '',
    surname: '',
    building: '',
    apartmentId: '',
    buildingId: '',
    imageUrl: '',
  );

  final _userRef = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;

  UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
    _userController.add(user);
    notifyListeners();
  }

  Future<UserModel?> getCurrentUser(String? uid) async {
    if (uid != null) {
      final snap = await _userRef.doc(uid).get();
      if (snap.exists) {
        return UserModel.fromFirestore(
            snap.data()!); // Firestore verilerini UserModel'e dönüştürün
      }
    }
    return null;
  }

  Future<bool> signUpUser(
    BuildContext context,
    String email,
    String username,
    String password,
    String name,
    String surname,
    String building,
    String imageUrl,
  ) async {
    bool res = false;
    bool usernameExists = await checkUsernameExists(username);
    if (usernameExists) {
      showSnackBar(context, 'Bu kullanıcı adı zaten kullanılıyor.');
      return false;
    }
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (cred.user != null) {
        UserModel user = UserModel(
          surname: surname.trim(),
          name: name.trim(),
          username: username.trim(),
          email: email.trim(),
          building: building.trim(),
          uid: cred.user!.uid,
          apartmentId: '',
          buildingId: '',
          imageUrl: imageUrl.trim(),
        );
        await _userRef.doc(cred.user!.uid).set(user.toMap());

        setUser(user);
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }

  Future<bool> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    bool res = false;
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (cred.user != null) {
        UserModel? user = await getCurrentUser(cred.user!.uid);
        if (user != null) {
          setUser(user);
          res = true;
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }

  Future<bool> checkUsernameExists(String username) async {
    try {
      final querySnapshot =
          await _userRef.where('username', isEqualTo: username).get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // Hata durumu ele alınabilir
      return true; // Varsayılan olarak true döndürüldü
    }
  }

  // Diğer metodları burada devam ettirin

  // Diğer metodları burada devam ettirin

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void updateUser(UserModel user) {
    _user = user;
    _userController.add(user);
    notifyListeners();
  }

  Future<String> updatePP(String uid, String imageUrl) async {
    try {
      // Firestore'da uid değeriyle eşleşen belgeleri sorgulayın
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      // Belgeyi referans alın
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      // Belgedeki imageUrl alanını güncelleyin
      await documentSnapshot.reference.update({'imageUrl': imageUrl});

      UserModel updatedUser = _user.copyWith(imageUrl: imageUrl);
      updateUser(updatedUser);

      return imageUrl;
    } catch (e) {
      print("Profil resmi güncellenirken bir hata oluştu: $e");
      throw Exception("Profil resmi güncellenirken bir hata oluştu.");
    }
  }

  // dispose metoduyla StreamController'ı kapatmayı unutmayın
  void dispose() {
    _userController.close();
  }
}
