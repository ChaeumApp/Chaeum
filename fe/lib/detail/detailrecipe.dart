import 'package:dio/dio.dart';
import 'package:fe/api/click.dart';
import 'package:fe/recipe/recipedetail.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailRecipe extends StatefulWidget {
  const DetailRecipe({super.key});

  @override
  State<DetailRecipe> createState() => _DetailRecipeState();
}

class _DetailRecipeState extends State<DetailRecipe> {
  Dio dio = Dio();
  final serverURL = 'http://j9c204.p.ssafy.io';

  Future<dynamic> getDetailRecipe() async {
    try {
      final response = await dio.get('$serverURL/recipe');
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> clickRecipe(recipeId) async {
    var accessToken = context.read<UserStore>().accessToken;
    print(accessToken);
    if(accessToken != ''){
      try {
        final response = await dio.get('$serverURL/recipe/selected/$recipeId', queryParameters: {'recipeId' : recipeId},
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


  var recipes = [
    {'title' : '복숭아 잼', 'url' : 'https://www.youtube.com/watch?v=zqvatzbtXXg'},
    {'title' : '복숭아 우유', 'url' : 'https://www.youtube.com/watch?v=-ALrxisJdpI'},
    {'title' : '복숭아 통조림', 'url' : 'https://www.youtube.com/watch?v=hzkMaSGJEB4'},
  ];

 getYoutubeThumbnail(url){
   String id = url.substring(url.length -11);
   String quality = ThumbnailQuality.medium;
   return 'https://i3.ytimg.com/vi/$id/$quality.jpg';
 }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getDetailRecipe(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Center(child: SpinKitPulse(
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Image.asset('assets/images/repeat/bottom_logo.png',
                      height: 40),
                );
              },
            ));
          }

          else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),

              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          }


          else {
            return Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: (){
                        // 연결후 추가
                        clickRecipe(index);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => RecipeDetailPage(recipeId : recipes[index]['recipeId'])));
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5))
                            )
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: Image.network(getYoutubeThumbnail(recipes[index]['url'],),
                                  height: 100),
                            ),
                            Flexible(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(recipes[index]['title'] as String, style: TextStyle(
                                        fontSize: 15
                                    )),
                                    Icon(Icons.arrow_forward_ios, size: 15, color: Color(0xff868E96),)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
        });
  }
}
