import 'package:dio/dio.dart';


class MainApi {
  Dio dio = Dio();
  final serverURL = 'http://j9c204.p.ssafy.io:8080';

  Future<dynamic> getCategory() async {
    try {
      final response = await dio.post('$serverURL/category');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
