import 'package:dio/dio.dart';

class UserApi {
  final Dio dio = Dio(); // Dio HTTP 클라이언트 초기화
  final serverURL = 'http://j9c204.p.ssafy.io:8080';

  Future<dynamic> login(id, password) async {
    try {
      final response = await dio.post('$serverURL/user/signin',
          data: {'userEmail': id, 'userPwd': password});
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
      final response =
          await dio.post('$serverURL/user/auth/sendEmail', data: id);
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> checkcode(id, code) async {
    try {
      final response = await dio.post('$serverURL/user/auth/checkEmail/$code',
          data: id, queryParameters: {'code': code});
      print('코드 확인 여부 ${response.data}');
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  // 다른 API 호출 메서드 추가
}
