import 'package:dio/dio.dart';


Dio dio = Dio(BaseOptions(
  baseUrl: 'http://j9c204.p.ssafy.io:8080',
  // 토큰 넣는거 필요하면
  headers: {'Authorization': 'Bearer Token'},
));


// 상품 클릭하는거
Future<dynamic> clickItem() async {
  try {
    final response = await dio.post('/item/selected');
    return response.data;
  } catch (e) {
    print(e);
  }
}


// 소분류 클릭
Future<dynamic> clickIngr() async {
  try {
    final response = await dio.post('/ingr/selected');
    return response.data;
  } catch (e) {
    print(e);
  }
}

// 레시피 클릭
Future<dynamic> clickRecipe(recipeId) async {
  try {
    final response = await dio.get('/recipe/selected/$recipeId');
    return response.data;
  } catch (e) {
    print(e);
  }
}
