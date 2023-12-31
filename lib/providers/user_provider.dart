import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  FutureOr<void> refreshUser() async {
    User user = await _authMethods.getUserDetail();
    _user = user;
    // 刷新
    notifyListeners();
  }
}
