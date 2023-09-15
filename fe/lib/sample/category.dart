import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CategorySample extends StatefulWidget {
  const CategorySample({super.key});

  @override
  State<CategorySample> createState() => _CategorySampleState();
}

class _CategorySampleState extends State<CategorySample> {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    // 토큰 넣는거 필요하면
    // headers: {'Authorization': 'Bearer Token'},
  ));

// 대분류 조회
  var categoryLarge = [];

  Future<void> getCategory(email) async {
    try {
      Response response =
          await dio.post('/category', data: {'userEmail': email});
      setState(() {
        categoryLarge = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
