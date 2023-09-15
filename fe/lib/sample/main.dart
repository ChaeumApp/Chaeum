import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MainSample extends StatefulWidget {
  const MainSample({super.key});

  @override
  State<MainSample> createState() => _MainSampleState();
}

class _MainSampleState extends State<MainSample> {


  Dio dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    // 토큰 넣는거 필요하면
    // headers: {'Authorization': 'Bearer Token'},
  ));


  // 대분류 목록 받아오기
  var category = [];

  Future<void> getCategory(email) async {
    try {
      Response response = await dio.get('/category');
      setState(() {
        category = response.data;
      });
    } catch (e) {
      print(e);
    }
  }



  // 베스트 목록 받아오기
  var bestList = [];

  Future<void> getBest(email) async {
    try {
      Response response = await dio.get('/main/best');
      setState(() {
        bestList = response.data;
      });

    } catch (e) {
      print(e);
    }
  }



  // 최저가 목록 받아오기
  var lowPriceList = [];

  Future<void> getLowPrice(email) async {
    try {
      Response response = await dio.get('/main/lowprice');
      setState(() {
        lowPriceList = response.data;
      });

    } catch (e) {
      print(e);
    }
  }

  // 상품 선택
  Future<void> clickItem(email, itemId) async {
    try {
      Response response = await dio.post('/item/selected',
          data: {'userEmail': email, 'itemId': itemId});
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  // 소분류 선택
  Future<void> clickCategory(email, ingrId) async {
    try {
      Response response = await dio.post('/ingr/selected',
          data: {'userEmail': email, 'ingrId': ingrId});
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
