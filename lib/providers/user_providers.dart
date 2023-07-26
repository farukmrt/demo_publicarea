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
  final _userController = StreamController<UserModel>.broadcast();
  Stream<UserModel> get userStream => _userController.stream;

  // final StreamController<UserModel> _userController =
  //     StreamController<UserModel>();
  // Stream<UserModel> get userStream =>
  //     _userController.stream; //.asBroadcastStream();

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
  //giriş yapan kullanıcıyı alma yöntemi
  //her defasında uid ile kullanici çekip işlemi yaptık

  UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
    _userController.add(user);
    notifyListeners();
  }

  void updateUser(UserModel user) {
    _user = user;
    _userController.add(_user);
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
      //sisteme giriş yapan kullanici aliniyoor
      User? user = FirebaseAuth.instance.currentUser;
      // yeniden kullanici sifre ve mail girisi
      AuthCredential credentials = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );

      // Kimlik dogrulama islemi
      UserCredential authResult =
          await user.reauthenticateWithCredential(credentials);

      // degerler dogru ise maili guncelle
      if (authResult.user != null) {
        // Authentication tarafi
        await user.updateEmail(newEmail);

        // Firestore'dan uid'sine gore kullaniciyi cek
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        // Kullanicinin email adresini guncelle
        await snapshot.reference.update({'email': newEmail});

        // ui'da gozuken _user degerini gucelle
        UserModel updatedUser = _user.copyWith(email: newEmail);
        updateUser(updatedUser);
        //notifyListeners();

        print("E-posta adresi güncellendi");
      } else {
        print("E-posta adresi güncelleme başarısız");
      }
    } catch (e) {
      print("E-posta adresi güncelleme hatası: $e");
    }
  }

  Future<void> updateUsername(BuildContext context, String uid,
      String newUsername, String currentPassword) async {
    try {
      // uid değerine göre kullanıcıyı çek
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      // mevcut şifreyi doğrula
      bool isPasswordCorrect = await verifyPassword(currentPassword);
      if (!isPasswordCorrect) {
        showSnackBar(context, "Geçerli şifre yanlış!");
      }

      // Yeni kullanıcı adının kullanılabilir olup olmadığını kontrol et
      bool isThereUsername = await checkUsername(newUsername);
      if (isThereUsername) {
        showSnackBar(context, "Bu kullanıcı adı zaten alınmış!");
        return;
      }

      await documentSnapshot.reference.update({'username': newUsername});

      UserModel updatedUser = _user.copyWith(username: newUsername);
      updateUser(updatedUser);
      showSnackBar(context, 'Kullanıcı adınız güncellendi...');
    } catch (e) {
      print("Kullanıcı adı güncelleme hatası: $e");
      showSnackBar(context, "Kullanıcı adı güncelleme hatası.");
    }
  }

  Future<void> updatePhoneNumber(
      String uid, String newPhoneNumber, String currentPassword) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception("Kullanıcı bulunamadı!");
      }

      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      bool isPasswordCorrect = await verifyPassword(currentPassword);
      if (!isPasswordCorrect) {
        print("Geçerli şifre yanlış!");
      }

      await documentSnapshot.reference.update({'phoneNumber': newPhoneNumber});

      UserModel updatedUser = _user.copyWith(phoneNumber: newPhoneNumber);
      updateUser(updatedUser);
    } catch (e) {
      print("Telefon numarası güncelleme hatası: $e");
    }
  }

  Future<bool> verifyPassword(String password) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      AuthCredential credentials = EmailAuthProvider.credential(
        email: user!.email!,
        password: password,
      );

      UserCredential authResult =
          await user.reauthenticateWithCredential(credentials);

      return authResult.user != null;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel?> getCurrentUser(String? uid) async {
    if (uid != null) {
      final snap = await _userRef.doc(uid).get();
      if (snap.exists) {
        //updateUser(user);
        return UserModel.fromFirestore(snap.data()!);
      }
      //updateUser();
    }
    return null;
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
          updateUser(user);
          notifyListeners();
          res = true;
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
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
    bool usernameExists = await checkUsername(username);
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

        updateUser(user); //_user değiştirilecek
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }

  Future<bool> checkUsername(String username) async {
    try {
      final querySnapshot =
          await _userRef.where('username', isEqualTo: username).get();
      print(querySnapshot);
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
      //updateUser(updatedUser);
      updateUser(updatedUser); //güncellenen yer
      return imageUrl;
    } catch (e) {
      print("Profil resmi güncellenirken bir hata oluştu: $e");
      throw Exception("Profil resmi güncellenirken bir hata oluştu.");
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      // Kullanıcıyı çıkış yaptıktan sonra, sistemdeki giris yapan kullanici verileri
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
    } catch (e) {
      showSnackBar(context, 'Çıkış yaparken bir hata oluştu.');
    }
  }

//en son butun dinleyicileri kapat
  void dispose() {
    _userController.close();
    super.dispose();
  }
}
