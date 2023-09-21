import 'package:dio/dio.dart';
import 'package:fe/api/firebaseapi.dart';
import 'package:flutter/material.dart';

class PageApi {
  final Dio dio = Dio(); // Dio HTTP 클라이언트 초기화
  final serverURL = 'http://j9c204.p.ssafy.io:8080';

  Future<dynamic> login(id, password, deviceToken) async {
    try {
      // final deviceToken = getMyDeviceToken();
      final response = await dio.post('$serverURL/user/signin', data: {
        'userEmail': id,
        'userPwd': password,
        'deviceToken': deviceToken
      });
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> duplicatecheck(id) async {
    try {
      final response = await dio.get('$serverURL/user/checkemail',
          queryParameters: {'userEmail': id});
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> sendEmail(id) async {
    try {
      final response = await dio
          .post('$serverURL/user/auth/sendEmail', data: {'userEmail': id});
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> checkcode(id, code) async {
    try {
      final response = await dio.post('$serverURL/user/auth/checkEmail/$code',
          data: {'userEmail': id}, queryParameters: {'code': code});
      print('코드 확인 여부 ${response.data}');
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> signup(
      id, pwd, birth, gender, vegan, alergylist, devicetoken) async {
    try {
      final response = await dio.post('$serverURL/user/signup', data: {
        'userEmail': id,
        'userPwd': pwd,
        'userBirthDay': birth,
        'userGender': gender,
        'veganId': int.parse(vegan),
        'allergyList': alergylist,
        'deviceToken': devicetoken
      });
      print('회원가입 여부 ${response.data}');
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getinfo(id, token) async {
    print(token);
    try {
      final response = await dio.post('$serverURL/user/mypage',
          data: {
            'userEmail': id,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // 토큰을 'Bearer' 스타일로 포함
              // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
            },
          ));
      print('개인정보 조회 ${response.data}');
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> kakaologin(token) async {
    try {
      print('받은토큰$token');
      final response = await dio.get('$serverURL/user/oAuth/kakao',
          queryParameters: {'token': token});
      print('ㅋ카오 로그인 여부 ${response.data}');
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }
  // 다른 API 호출 메서드 추가
}
