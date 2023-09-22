import 'package:dio/dio.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SearchMainRecipe extends StatefulWidget {
  const SearchMainRecipe({super.key});

  @override
  State<SearchMainRecipe> createState() => _SearchMainRecipeState();
}

class _SearchMainRecipeState extends State<SearchMainRecipe> {
  Dio dio = Dio();
  final serverURL = 'http://j9c204.p.ssafy.io:8080';

  Future<dynamic> getRecipe() async {
    try {
      final response = await dio.get('$serverURL/recipe');
      print(response.data.runtimeType);
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



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getRecipe(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.hasData == false) {
            return SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             ));
                      },
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              height: 210,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 16.0,
                              width: 200.0,
                              child: Container(color: Colors.white),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            SizedBox(
                              height: 16.0,
                              width: 250.0,
                              child: Container(color: Colors.white),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          else if (snapshot.hasError) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            );
          }
          else {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      clickRecipe(snapshot.data[index]['recipeId']);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             ));
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Image.network(
                              snapshot.data[index]['recipeThumbnail'],
                              height: 210,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            '채움의 ${index + 1}번째 추천 레시피🎁',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text('${snapshot.data[index]['recipeName']}'),
                          )
                        ],
                      ),
                    ),
                  );
                },
                childCount: 2, // 아이템 개수에 따라 설정
              ),
            );
        }
        });
  }
}
