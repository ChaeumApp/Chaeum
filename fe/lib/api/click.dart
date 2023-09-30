import 'package:dio/dio.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClickApi extends StatefulWidget {
  const ClickApi({super.key});

  @override
  State<ClickApi> createState() => _ClickApiState();
}

class _ClickApiState extends State<ClickApi> {

  Dio dio = Dio();
  final serverURL = 'https://j9c204.p.ssafy.io:8080';


// 상품 클릭하는거
  Future<dynamic> clickItem() async {
    var accessToken = context.read<UserStore>().accessToken;
    try {
      final response = await dio.post('/item/selected');
      return response.data;
    } catch (e) {
      print(e);
    }
  }


// 소분류 클릭
  Future<dynamic> clickIngr(ingrId) async {
    var accessToken = context.read<UserStore>().accessToken;
    if(accessToken != '') {
      try {
        final response = await dio.post('$serverURL/ingr/selected', data: {'ingrId' : ingrId},
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ),);
        print(response.data);
        return response.data;
      } catch (e) {
        print(e);
      }
    }
    }


// 레시피 클릭
  Future<dynamic> clickRecipe(recipeId) async {
    var accessToken = context.read<UserStore>().accessToken;
    try {
      final response = await dio.get('/recipe/selected/$recipeId');
      return response.data;
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}