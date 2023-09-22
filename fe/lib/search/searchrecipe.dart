import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchRecipe extends StatefulWidget {
  const SearchRecipe({super.key});

  @override
  State<SearchRecipe> createState() => _SearchRecipeState();
}

class _SearchRecipeState extends State<SearchRecipe> {
  Dio dio = Dio();
  final serverURL = 'http://j9c204.p.ssafy.io:8080';

  Future<dynamic> searchRecipe() async {
    try {
      final response = await dio.get('$serverURL/recipe');
      return response.data;
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: searchRecipe(),
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
            return ListView.builder(
              itemCount: (snapshot.data.length + 2), // 변경된 itemCount
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 3),
                    child: Text(
                      '레시피 검색 결과',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  );
                } else if (index == 1) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
                    child: Text('총 ${snapshot.data.length}개 상품'),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(snapshot.data[index]['recipeThumbnail'],
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.fill),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 15, 0, 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset('assets/images/recipe/recipe.png',
                                    height: 40,
                                    width: 40,),
                                ),
                                SizedBox(width: 15,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${snapshot.data[index]['recipeName']}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),softWrap: true,),
                                      Text('만개의 레시피',
                                      style: TextStyle(
                                        color: Colors.black54
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
    );
  }
}
