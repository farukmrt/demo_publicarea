import 'package:flutter/material.dart';
import 'package:demo_publicarea/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    uid: '',
    email: '',
    username: '',
    name: '',
    surname: '',
  );

  User get user => _user;

  setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
