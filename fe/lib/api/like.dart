import 'package:dio/dio.dart';


Dio dio = Dio(BaseOptions(
  baseUrl: 'http://j9c204.p.ssafy.io:8080',
  // 토큰 넣는거 필요하면
  headers: {'Authorization': 'Bearer Token'},
));


// 상품 좋아요
Future<dynamic> likeItem() async {
  try {
    final response = await dio.post('/item/selected');
    return response.data;
  } catch (e) {
    print(e);
  }
}


// 소분류 좋아요
Future<dynamic> likeIngr() async {
  try {
    final response = await dio.post('/ingr/favorite');
    return response.data;
  } catch (e) {
    print(e);
  }
}

// 레시피 좋아요
Future<dynamic> likeRecipe(recipeId) async {
  try {
    final response = await dio.get('/recipe/favorite/$recipeId');
    return response.data;
  } catch (e) {
    print(e);
  }
}
