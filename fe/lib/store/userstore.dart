import 'package:flutter/material.dart';

class UserStore extends ChangeNotifier {
  String? deviceToken;
  savedevicetoken(token) {
    deviceToken = token;
  }

  String userId = '';
  changeUserInfo(userInfo) {
    userId = userInfo;
  }

  List<String?> searchList = [];
  addSearchList(searchWord) {
    if (searchList.length >= 10) {
      searchList.removeAt(searchList.length - 1);
    }
    searchList.insert(0, searchWord);
  }

  deleteSearchList(index) {
    searchList.removeAt(index);
  }
}
