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
    // headers: {'Authorization': 'Bearer Token'},
  ));

  //로그인
  Future<void> login() async {
    try {
      Response response = await dio.post('/user/signin',
          data: {'userEmail': 'ssafy', 'userPwd': 'pass123!'});
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
