import 'package:app1/models/user.dart';
import 'package:app1/resources/authMethods.dart';
import 'package:flutter/material.dart';


class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  User? get getUser => _user;
  Future<void> refreshUser(bool internal) async {
    try {
      User? user = await _authMethods.getUserDetails();
      if (internal) {
        if (_user == null) {
          _user = user;
          // print("new user");

          notifyListeners();
        }
      } else {
        _user = user;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
