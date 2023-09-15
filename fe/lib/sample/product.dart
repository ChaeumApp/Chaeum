import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ProductSample extends StatefulWidget {
  const ProductSample({super.key});

  @override
  State<ProductSample> createState() => _ProductSampleState();
}

class _ProductSampleState extends State<ProductSample> {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    // 토큰 넣는거 필요하면
    // headers: {'Authorization': 'Bearer Token'},
  ));

// 관심없음
  Future<void> dislike(email, itemId) async {
    try {
      Response response = await dio
          .post('/dislike', data: {'userEmail': email, 'itemId': itemId});
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

//사용자 상품 선택 로그 기록

  Future<void> getLogchoice(email, itemId) async {
    try {
      Response response = await dio
          .post('/ingr/detail', data: {'userEmail': email, 'itemId': itemId});
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
