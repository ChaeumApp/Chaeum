import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class RecipeSample extends StatefulWidget {
  const RecipeSample({super.key});

  @override
  State<RecipeSample> createState() => _RecipeSampleState();
}

class _RecipeSampleState extends State<RecipeSample> {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    // 토큰 넣는거 필요하면
    // headers: {'Authorization': 'Bearer Token'},
  ));

// 즐겨찾기&취소
  Future<void> favorite(recipeid) async {
    try {
      Response response = await dio.get(
        '/favorite/recipe',
        data: {'recipeid': recipeid},
      );
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

// 레시피 상세 조회
  var categoryDetail = [];

  Future<void> getRecipe(recipeid) async {
    try {
      Response response =
          await dio.get('detail/$recipeid', data: {'recipeid': recipeid});
      setState(() {
        categoryDetail = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  // 레시피 정보업데이트
  var upRecipe = [];

  Future<void> getRecUpadate(email, ingrId) async {
    try {
      Response response = await dio.get(
        '/update',
      );
      setState(() {
        upRecipe = response.data;
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
