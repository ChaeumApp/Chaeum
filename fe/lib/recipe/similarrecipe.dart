import 'package:dio/dio.dart';
import 'package:fe/recipe/recipedetail.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';



class SimilarRecipe extends StatefulWidget {
  const SimilarRecipe({super.key, this.recipeId});
  final recipeId;

  @override
  State<SimilarRecipe> createState() => _SimilarRecipeState();
}



class _SimilarRecipeState extends State<SimilarRecipe> {
  Dio dio = Dio();
  final serverURL = 'https://j9c204.p.ssafy.io';

  Future<dynamic> getSimilarRecipe() async {
    try {
      final response = await dio.get('$serverURL/recipe/similar/${widget.recipeId}');
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
    return FutureBuilder(future: getSimilarRecipe(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.hasData == false) {
            return SliverToBoxAdapter(
              child: Center(child: SpinKitPulse(
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Image.asset('assets/images/repeat/bottom_logo.png',
                        height: 40),
                  );
                },
              )),
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
                        onTap: (){
                          clickRecipe(snapshot.data[index]['recipeId']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecipeDetailPage(recipeId : snapshot.data[index]['recipeId'])));
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Image.network(snapshot.data[index]['recipeThumbnail'],
                                  height: 230,
                                  width: double.infinity,
                                  fit: BoxFit.cover),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset('assets/images/recipe/recipe.png',
                                        height: 40,
                                        width: 40,),
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${snapshot.data[index]['recipeName']}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),softWrap: true,),
                                          Text('만개의 레시피',
                                            style: TextStyle(
                                                color: Colors.black54
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      );
                    }, childCount: snapshot.data.length));
          }

        });
  }
}
