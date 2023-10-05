import 'package:dio/dio.dart';
import 'package:fe/api/firebaseapi.dart';
import 'package:fe/user/findpassword.dart';
import 'package:flutter/material.dart';

class PageApi {
  final Dio dio = Dio(); // Dio HTTP 클라이언트 초기화
  final serverURL = 'https://j9c204.p.ssafy.io';
  // final serverURL = 'http://10.0.2.2:8080';

  Future<dynamic> login(id, password, deviceToken) async {
    try {
      // final deviceToken = getMyDeviceToken();
      final response = await dio.post('$serverURL/user/signin', data: {
        'userEmail': id,
        'userPwd': password,
        'notiToken': deviceToken
      });
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> duplicatecheck(id) async {
    try {
      final response = await dio.get('$serverURL/user/checkemail',
          queryParameters: {'userEmail': id});
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> sendEmail(id) async {
    try {
      final response = await dio
          .post('$serverURL/user/auth/sendEmail', data: {'userEmail': id});
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> checkcode(id, code) async {
    try {
      final response = await dio.post('$serverURL/user/auth/checkEmail/$code',
          data: {'userEmail': id}, queryParameters: {'code': code});
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> signup(
      id, pwd, birth, gender, vegan, alergylist, deviceToken) async {
    try {
      final response = await dio.post('$serverURL/user/signup', data: {
        'userEmail': id,
        'userPwd': pwd,
        'userBirthday': birth,
        'userGender': gender,
        'veganId': vegan,
        'allergyList': alergylist,
        'notiToken': deviceToken
      });
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getinfo(token) async {
    try {
      final response = await dio.post('$serverURL/user/mypage',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // 토큰을 'Bearer' 스타일로 포함
              // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
            },
          ));
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> kakaologin(token, deviceToken) async {
    try {
      final response = await dio.get('$serverURL/user/oAuth/kakao',
          queryParameters: {'token': token, 'notiToken': deviceToken});
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> naverlogin(token, deviceToken) async {
    try {
      final response = await dio.get('$serverURL/user/oAuth/naver',
          queryParameters: {'token': token, 'notiToken': deviceToken});
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> updateuserinfo(
      token, selectedVeganNumber, selectedAllergieNumber) async {
    try {
      final response = await dio.put('$serverURL/user',
          data: {
            'veganId': selectedVeganNumber,
            'allergyList': selectedAllergieNumber
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // 토큰을 'Bearer' 스타일로 포함
              // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
            },
          ));
      print('유저 정보 수정 ${response.data}');
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> findPassword(id, birth) async {
    try {
      final response = await dio.post('$serverURL/user/find/pwd',
          data: {'userBirthday': birth, 'userEmail': id});
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> changepassword(token, curpwd, nextpwd) async {
    try {
      final response = await dio.post('$serverURL/user/pwd',
          data: {'curpassword': curpwd, 'nextpassword': nextpwd},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // 토큰을 'Bearer' 스타일로 포함
              // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
            },
          ));
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> logout(token) async {
    try {
      final response = await dio.post('$serverURL/user/signout',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // 토큰을 'Bearer' 스타일로 포함
              // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
            },
          ));
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> tokenValidation(token) async {
    try {
      final response = await dio.post('$serverURL/user/auth/checktoken',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // 토큰을 'Bearer' 스타일로 포함
              // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
            },
          ));
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> deleteuser(token, id) async {
    try {
      final response = await dio.delete('$serverURL/user',
          data: {"userEmail": id},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // 토큰을 'Bearer' 스타일로 포함
              // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
            },
          ));
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }
}
