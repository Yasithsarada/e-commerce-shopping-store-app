import 'package:flutter/material.dart';
import 'package:online_shopping_store/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: "",
    username: "",
    email: "",
    password: "",
    token: "",
    googleId: '',
    imageUrl: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
