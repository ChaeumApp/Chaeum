import 'package:dio/dio.dart';
import 'package:fe/api/click.dart';
import 'package:fe/recipe/recipedetail.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailRecipe extends StatefulWidget {
  const DetailRecipe({super.key, this.ingrId});
  final ingrId;

  @override
  State<DetailRecipe> createState() => _DetailRecipeState();
}

class _DetailRecipeState extends State<DetailRecipe> {
  Dio dio = Dio();
  final serverURL = 'http://j9c204.p.ssafy.io';

  Future<dynamic> getDetailRecipe() async {
    try {
      final response = await dio.get('$serverURL/ingr/${widget.ingrId}/recipe');
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
            if(snapshot.data.length > 0){
              return Container(
                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      return GestureDetector(
                        onTap: (){
                          // 연결후 추가
                          clickRecipe(snapshot.data[index]['recipeId']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecipeDetailPage(recipeId : snapshot.data[index]['recipeId'])));
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
                                child: Image.network(snapshot.data[index]['recipeThumbnail'],
                                    height: 100),
                              ),
                              Flexible(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 4,
                                        child: Text(snapshot.data[index]['recipeName'] as String,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 15
                                            )),
                                      ),
                                      Flexible(
                                          flex: 1,
                                          child: Icon(Icons.arrow_forward_ios, size: 15, color: Color(0xff868E96),))
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
            } else {
              return Center(
                child: Text('관련된 레시피가 없습니다.',
                style: TextStyle(
                  fontSize: 16
                ),),
              );
            }
          }
        });
  }
}
