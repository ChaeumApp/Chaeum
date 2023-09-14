import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStore extends ChangeNotifier {
  final storage = FlutterSecureStorage();
  var userInfo = '';

  changeUserInfo(userInfo) {
    userInfo = userInfo;
  }
}
