import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class LoginSample extends StatefulWidget {
  const LoginSample({super.key});

  @override
  State<LoginSample> createState() => _LoginSampleState();
}

class _LoginSampleState extends State<LoginSample> {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    // 토큰 넣는거 필요하면
    headers: {'Authorization': 'Bearer Token'},
  ));

  //로그인
  Future<void> login() async {
    try {
      Response response = await dio.post('/user/signin',
          data: {'userEmail': 'ww@ssafy.com', 'userPwd': 'pass123!'});
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signup() async {
    try {
      Response response = await dio.post('/user/signup', data: {
        "userActivated": true,
        "userBirthday": "string",
        "userEmail": "string",
        "userGender": "string",
        "userId": 0,
        "userPwd": "string",
        "veganId": 0
      });
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signout() async {
    try {
      Response response = await dio.post('/user/signout', data: {});
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> finduserpwd() async {
    try {
      Response response = await dio.post('/user/find/pwd', data: {
        "userEmail": "string",
        "userBirthday": "string",
      });
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteuser() async {
    try {
      Response response = await dio.delete('/user', data: {
        "userEmail": "string",
      });
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateuser() async {
    try {
      Response response = await dio.put('/user', data: {
        "userEmail": "string",
      });
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getuserinfo() async {
    try {
      Response response = await dio.get('/user/mypage', data: {
        "userEmail": "string",
      });
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    login();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
