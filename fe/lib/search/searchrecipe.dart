import 'package:dio/dio.dart';
import 'package:fe/recipe/recipedetail.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchRecipe extends StatefulWidget {
  const SearchRecipe({super.key, this.scrollController, this.data});
  final scrollController;
  final data;

  @override
  State<SearchRecipe> createState() => _SearchRecipeState();
}

class _SearchRecipeState extends State<SearchRecipe> {
  Dio dio = Dio();
  final serverURL = 'https://j9c204.p.ssafy.io';


  Future<dynamic> clickRecipe(recipeId) async {
    var accessToken = context.read<UserStore>().accessToken;
    print(accessToken);
    if(accessToken != ''){
      try {
        final response = await dio.get('$serverURL/recipe/selected/$recipeId', queryParameters: {'recipeId' : recipeId},
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ),);
        return response.data;
      } catch (e) {
        print(e);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.scrollController,
      itemCount: (widget.data.length + 2),
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
            child: Text('총 ${widget.data.length}개 레시피'),
          );
        } else {
          return GestureDetector(
            onTap: (){
              clickRecipe(widget.data[index]['recipeId']);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeDetailPage(recipeId : widget.data[index]['recipeId'])));
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(widget.data[index]['recipeThumbnail'],
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
                              Text('${widget.data[index]['recipeName']}',
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
            ),
          );
        }
      },
    );
  }
}
