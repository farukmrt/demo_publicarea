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
import 'package:demo_publicarea/screens/login/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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
    phoneNumber: '',
  );

  final _auth = FirebaseAuth.instance;
  final _userRef = FirebaseFirestore.instance.collection('users');
  final _currentUser = FirebaseAuth.instance.currentUser;

  UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
    _userController.add(user);
    notifyListeners();
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    try {
      // Mevcut kullanıcıyı alın
      User? user = FirebaseAuth.instance.currentUser;

      // Mevcut kullanıcıyı yeniden kimlik doğrulamak için email ve şifreyle giriş yapın
      AuthCredential credentials = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );

      // Kimlik doğrulama işlemini gerçekleştirin
      UserCredential authResult =
          await user.reauthenticateWithCredential(credentials);

      // Kimlik doğrulama başarılı ise yeni şifreyi güncelleyin
      if (authResult.user != null) {
        await user.updatePassword(newPassword);
        print("Şifre güncellendi");
      } else {
        print("Şifre güncelleme başarısız");
      }
    } catch (e) {
      print("Şifre güncelleme hatası: $e");
    }
  }

  Future<void> updateEmail(String currentPassword, String newEmail) async {
    try {
      // Mevcut kullanıcıyı alın
      User? user = FirebaseAuth.instance.currentUser;

      // Mevcut kullanıcıyı yeniden kimlik doğrulamak için email ve şifreyle giriş yapın
      AuthCredential credentials = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );

      // Kimlik doğrulama işlemini gerçekleştirin
      UserCredential authResult =
          await user.reauthenticateWithCredential(credentials);

      // Kimlik doğrulama başarılı ise yeni e-posta adresini güncelleyin
      if (authResult.user != null) {
        // Authentication tarafında e-posta adresini güncelle
        await user.updateEmail(newEmail);

        // Firestore'dan kullanıcıyı alın
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        // Kullanıcının e-posta alanını güncelle
        await snapshot.reference.update({'email': newEmail});

        // _user değişkenini güncelle
        _user = _user.copyWith(email: newEmail);
        notifyListeners();

        print("E-posta adresi güncellendi");
      } else {
        print("E-posta adresi güncelleme başarısız");
      }
    } catch (e) {
      print("E-posta adresi güncelleme hatası: $e");
    }
  }

  // Future<void> updateUsername(
  //     String newUsername, String currentPassword) async {
  //   try {
  //     // Get the current user
  //     User? user = FirebaseAuth.instance.currentUser;

  //     // Reauthenticate the user with email and password
  //     AuthCredential credentials = EmailAuthProvider.credential(
  //       email: user!.email!,
  //       password: currentPassword,
  //     );

  //     // Perform reauthentication
  //     UserCredential authResult =
  //         await user.reauthenticateWithCredential(credentials);

  //     // If reauthentication is successful, update the username
  //     if (authResult.user != null) {
  //       // Update the username in Firebase Authentication
  //       await user.updateDisplayName(newUsername);

  //       // Update the username property in your UserProvider class
  //       user = FirebaseAuth.instance.currentUser; // Refresh the user data
  //       notifyListeners(); // Notify listeners about the change in the UserProvider class

  //       print("Username updated");
  //     } else {
  //       print("Username update failed");
  //     }
  //   } catch (e) {
  //     print("Error updating username: $e");
  //   }
  // }
  Future<void> updateUsername(
      String uid, String newUsername, String currentPassword) async {
    try {
      // uid değerine göre kullanıcıyı sorgulayın
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception("Kullanıcı bulunamadı!");
      }

      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      // Kullanıcının mevcut şifresini doğrula
      bool isPasswordCorrect = await verifyPassword(currentPassword);
      if (!isPasswordCorrect) {
        throw Exception("Geçerli şifre yanlış!");
      }

      // Belgedeki username alanını güncelle
      await documentSnapshot.reference.update({'username': newUsername});

      UserModel updatedUser = _user.copyWith(username: newUsername);
      updateUser(updatedUser);
    } catch (e) {
      print("Kullanıcı adı güncelleme hatası: $e");
      throw Exception("Kullanıcı adı güncelleme hatası.");
    }
  }

  Future<void> updatePhoneNumber(
      String uid, String newPhoneNumber, String currentPassword) async {
    try {
      // uid değerine göre kullanıcıyı sorgulayın
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception("Kullanıcı bulunamadı!");
      }

      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      // Kullanıcının mevcut şifresini doğrula
      bool isPasswordCorrect = await verifyPassword(currentPassword);
      if (!isPasswordCorrect) {
        throw Exception("Geçerli şifre yanlış!");
      }

      // Belgedeki username alanını güncelle
      await documentSnapshot.reference.update({'phoneNumber': newPhoneNumber});

      UserModel updatedUser = _user.copyWith(phoneNumber: newPhoneNumber);
      updateUser(updatedUser);
    } catch (e) {
      print("Telefon numarası güncelleme hatası: $e");
      throw Exception("Telefon numarası güncelleme hatası.");
    }
  }

  Future<bool> verifyPassword(String password) async {
    try {
      // Mevcut kullanıcıyı alın
      User? user = FirebaseAuth.instance.currentUser;

      // E-posta ve şifreyle kimlik doğrulamak için credentials oluşturun
      AuthCredential credentials = EmailAuthProvider.credential(
        email: user!.email!,
        password: password,
      );

      // Kimlik doğrulama işlemini gerçekleştirin
      UserCredential authResult =
          await user.reauthenticateWithCredential(credentials);

      // Kimlik doğrulama başarılı ise true döndürün
      return authResult.user != null;
    } catch (e) {
      // Kimlik doğrulama başarısız ise false döndürün
      return false;
    }
  }

  Future<UserModel?> getCurrentUser(String? uid) async {
    if (uid != null) {
      final snap = await _userRef.doc(uid).get();
      if (snap.exists) {
        return UserModel.fromFirestore(snap.data()!);
      }
      updateUser(_user);
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
      String phoneNumber) async {
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
          phoneNumber: phoneNumber.trim(),
        );
        await _userRef.doc(cred.user!.uid).set(user.toMap());

        updateUser(_user); //_user değiştirilecek
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
          //setUser(user);
          //updateUser(user);
          notifyListeners();
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
      return true;
    }
  }

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
      // uid değerine göre sorgu yapıyoruz
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      // Belgedeki imageUrl alanını güncellendiğimiz kısım
      await documentSnapshot.reference.update({'imageUrl': imageUrl});

      UserModel updatedUser = _user.copyWith(imageUrl: imageUrl);
      updateUser(updatedUser);
      //setUser(updatedUser); //güncellenen yer
      return imageUrl;
    } catch (e) {
      print("Profil resmi güncellenirken bir hata oluştu: $e");
      throw Exception("Profil resmi güncellenirken bir hata oluştu.");
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      // Kullanıcıyı çıkış yaptıktan sonra, yerel kullanıcı nesnesini ve akışı sıfırlıyoruz
      _user = UserModel(
        uid: '',
        email: '',
        username: '',
        name: '',
        surname: '',
        building: '',
        apartmentId: '',
        buildingId: '',
        imageUrl: '',
        phoneNumber: '',
      );
      _userController.add(_user);
      //setUser(_user); // güncellenen yer
      notifyListeners();

      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const OnboardingScreen(),
        withNavBar: false,
      );
      // Navigator.pop(context);
    } catch (e) {
      showSnackBar(context, 'Çıkış yaparken bir hata oluştu.');
    }
  }

  // dispose metoduyla StreamController'ı kapatmayı unutmayın
  void dispose() {
    _userController.close();
    super.dispose();
  }
}
