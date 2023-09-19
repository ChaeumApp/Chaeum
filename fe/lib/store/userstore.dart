import 'package:flutter/material.dart';

class UserStore extends ChangeNotifier {
  String userId = '';

  changeUserInfo(userInfo) {
    userId = userInfo;
  }
}
