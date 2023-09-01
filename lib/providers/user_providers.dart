import 'dart:async';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/providers/building_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_publicarea/utils/languages/lang.dart';
import 'package:demo_publicarea/screens/login/onboard_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class UserProvider extends ChangeNotifier {
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
    registrationTime: Timestamp.now(),
  );

  final _auth = FirebaseAuth.instance;
  final _userRef = FirebaseFirestore.instance.collection('users');

  //final _currentUser = FirebaseAuth.instance.currentUser;
  //giriş yapan kullanıcıyı alma yöntemi
  //her defasında uid ile kullanici çekip işlemi yaptık

  //UserModel get user => _user;

  late UserModel currentUser;

  void updateCurrentUser(UserModel user) {
    if (user.uid != "") {
      currentUser = user;
    }
    notifyListeners();
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
        //updateUser(_user);
        UserModel? user = await getCurrentUser(cred.user!.uid);
        if (user != null) {
          //setUser(user);
          updateCurrentUser(user);
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

  Future<bool> signUpUser(
    BuildContext context,
    String email,
    String username,
    String password,
    String name,
    String surname,
    String building,
    String imageUrl,
    String phoneNumber,
    String buildingId,
  ) async {
    bool res = false;
    bool usernameExists = await checkUsername(context, username);
    if (usernameExists) {
      showSnackBar(
          context, translation(context).lcod_lbl_message_used_username);
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
          imageUrl: imageUrl.trim(),
          phoneNumber: phoneNumber.trim(),
          registrationTime: Timestamp.now(),
          buildingId: buildingId,
        );
        await _userRef.doc(cred.user!.uid).set(user.toMap());

        updateCurrentUser(user); //_user değiştirilecek
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }

  // signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser =
  //       await GoogleSignIn(scopes: <String>['email']).signIn();
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser!.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: ['email', 'profile'],
    ).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // final GoogleSignInAccount? account = await GoogleSignIn().signInSilently();
    // final GoogleSignInAuthentication auth = await account!.authentication;
    //final String? phoneNumber = account.phoneNumber;
    if (googleUser != null) {
      final email = googleUser.email;
      final displayName = googleUser.displayName;
      final photoUrl = googleUser.photoUrl;
      final uid = googleUser.id;

      UserModel user = UserModel(
          uid: googleUser.id,
          email: googleUser.email,
          username: '',
          name: googleUser.displayName!,
          surname: '',
          building: '',
          apartmentId: '',
          buildingId: '',
          imageUrl: googleUser.photoUrl ?? '',
          phoneNumber: '',
          registrationTime: Timestamp.now());

      updateCurrentUser(user);
    }

    // final authResult =
    //     await FirebaseAuth.instance.signInWithCredential(credential);
    // if (authResult.user != null) {
    //   UserModel user = UserModel(
    //     uid: authResult.user!.uid,
    //     email: authResult.user!.email!,
    //     name: authResult.user!.displayName!,
    //     surname: '',
    //     username: '',
    //     apartmentId: '',
    //     building: '',
    //     buildingId: '',
    //     imageUrl: authResult.user!.photoURL!,
    //     phoneNumber: authResult.user!.phoneNumber ?? '05XX',
    //     registrationTime: Timestamp.now(),
    //   );
    //   // _userRef.doc(user.uid).set(user.toMap());
    //   updateCurrentUser(user);
    // }
  }

//   void signInWithGoogle() async {
//   final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
//   final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

//   if (googleUser != null) {
//     // Google People API için yetkilendirme
//     final peopleApi = people.PeopleApi(await googleUser.authHeaders);

//     // Google kullanıcısının e-posta ve adı
//     final String email = googleUser.email;
//     final String displayName = googleUser.displayName!;

//     // Google kullanıcısının profil fotoğrafı
//     final String? photoUrl = googleUser.photoUrl;

//     // Google People API aracılığıyla telefon numarasını al
//     final people.Person mePerson = await peopleApi.people.get('people/me',
//         personFields: 'phoneNumbers') as people.Person;

//     // Telefon numarasını alma
//     String? phoneNumber;
//     if (mePerson.phoneNumbers != null && mePerson.phoneNumbers!.isNotEmpty) {
//       phoneNumber = mePerson.phoneNumbers![0].value;
//     }

//     // Alınan bilgileri kullanarak istediğiniz işlemleri yapabilirsiniz
//     print('E-Posta: $email');
//     print('Ad: $displayName');
//     print('Profil Fotoğrafı URL: $photoUrl');
//     print('Telefon Numarası: $phoneNumber');
//   }
// }

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
        registrationTime: Timestamp.now(),
      );
      notifyListeners();
      await BuildingProvider().signOutBuilding(context);
      BuildingProvider().notifyListeners();
      // _userController.add(_user);
      //setUser(_user); // güncellenen yer

      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const OnboardingScreen(),
        withNavBar: false,
      );
    } catch (e) {
      showSnackBar(
          context,
          translation(context)
              .lcod_lbl_message_error_logout); //'Çıkış yaparken bir hata oluştu.');
    }
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
        UserModel updatedUser = currentUser.copyWith(email: newEmail);

        updateCurrentUser(updatedUser);

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
        showSnackBar(context, translation(context).lcod_lbl_message_password);
      }

      // Yeni kullanıcı adının kullanılabilir olup olmadığını kontrol et
      bool isThereUsername = await checkUsername(context, newUsername);
      if (isThereUsername) {
        showSnackBar(
            context, translation(context).lcod_lbl_message_taken_username);
        return;
      }

      await documentSnapshot.reference.update({'username': newUsername});

      UserModel updatedUser = currentUser.copyWith(username: newUsername);

      updateCurrentUser(updatedUser);

      // showSnackBar(
      //     context, translation(context).lcod_lbl_message_update_username);
    } catch (e) {
      print("Kullanıcı adı güncelleme hatası: $e");
      showSnackBar(
          context, translation(context).lcod_lbl_message_error_username);
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

      UserModel updatedUser = currentUser.copyWith(phoneNumber: newPhoneNumber);

      updateCurrentUser(updatedUser);
    } catch (e) {
      print("Telefon numarası güncelleme hatası: $e");
    }
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

      UserModel updatedUser = currentUser.copyWith(imageUrl: imageUrl);
      //updateUser(updatedUser);
      updateCurrentUser(updatedUser); //güncellenen yer
      return imageUrl;
    } catch (e) {
      print("Profil resmi güncellenirken bir hata oluştu: $e");

      throw Exception("Profil resmi güncellenirken bir hata oluştu.");
    }
  }

  String updateBuildingId(String buildingId) {
    _user = _user.copyWith(buildingId: buildingId);
    notifyListeners();
    return buildingId;
  }

  void updateBuildinId(String buildingId) {
    _user = _user.copyWith(buildingId: buildingId);
    notifyListeners();
  }

  Future<UserModel?> getCurrentUser(String? uid) async {
    if (uid != null) {
      final snap = await _userRef.doc(uid).get();
      if (snap.exists) {
        return UserModel.fromFirestore(snap.data()!);
      }
    }
    return null;
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

  Future<bool> checkUsername(BuildContext? context, String username) async {
    try {
      final querySnapshot =
          await _userRef.where('username', isEqualTo: username).get();
      print(querySnapshot);
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      showSnackBar(
          context!, translation(context).lcod_lbl_message_taken_username);
      return true;
    }
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

//en son butun dinleyicileri kapatıyoruz
  void dispose() {
    // _userController.close();
    super.dispose();
  }
}
