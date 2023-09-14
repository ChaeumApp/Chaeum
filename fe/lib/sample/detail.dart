import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DetailSample extends StatefulWidget {
  const DetailSample({super.key});

  @override
  State<DetailSample> createState() => _DetailSampleState();
}

class _DetailSampleState extends State<DetailSample> {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    // 토큰 넣는거 필요하면
    // headers: {'Authorization': 'Bearer Token'},
  ));

// 즐겨찾기
  Future<void> favorite(email) async {
    try {
      Response response =
          await dio.post('/favorite', data: {'userEmail': email});
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

// 소분류 받아오기
  var categoryDetail = [];

  Future<void> getCategory(email, ingrId) async {
    try {
      Response response = await dio
          .post('/ingr/detail', data: {'userEmail': email, 'ingrId': ingrId});
      setState(() {
        categoryDetail = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  // 소분류 추천상품
  var recProduct = [];

  Future<void> getRecProduct(email, ingrId) async {
    try {
      Response response = await dio.post('/ingr/detail/product',
          data: {'userEmail': email, 'ingrId': ingrId});
      setState(() {
        recProduct = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  // 소분류 가격정보
  var priceInfo = [];

  Future<void> getPriceInfo(email, ingrId) async {
    try {
      Response response = await dio.post('/ingr/detail/price',
          data: {'userEmail': email, 'ingrId': ingrId});
      setState(() {
        priceInfo = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  // 소분류 레시피
  var recipeList = [];

  Future<void> getRecipeList(email, ingrId) async {
    try {
      Response response = await dio.post('/ingr/detail/recipe',
          data: {'userEmail': email, 'ingrId': ingrId});
      setState(() {
        recipeList = response.data;
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
