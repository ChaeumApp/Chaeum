import 'package:dio/dio.dart';
import 'package:fe/recipe/player.dart';
import 'package:fe/recipe/similarrecipe.dart';
import 'package:fe/repeat/needlogin.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:like_button/like_button.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({super.key, this.recipeId});

  final recipeId;

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  Dio dio = Dio();
  final serverURL = 'https://j9c204.p.ssafy.io';

  bool isSet = false;
  bool tmpSaved = false;
  Future<dynamic> loadRecipe(recipeId) async {
    var accessToken = context.read<UserStore>().accessToken;
    print(accessToken);
    if (accessToken != '') {
      try {
        final response = await dio.get(
          '$serverURL/recipe/detail/$recipeId',
          data: {'recipeId': recipeId},
          options: Options(
            headers: {
              'Authorization': accessToken != '' ? 'Bearer $accessToken' : ''
            },
          ),
        );
        if (!isSet) {
          setState(() {
            tmpSaved = response.data['savedRecipe'];
            isSet = true;
          });
        }
        return response.data;
      } catch (e) {
        print(e);
      }
    } else {
      try {
        final response = await dio.get('$serverURL/recipe/detail/$recipeId',
            data: {'recipeId': recipeId});
        return response.data;
      } catch (e) {
        print(e);
      }
    }
  }



  Future<bool?> toggleLike(bool isLiked) async {
    bool liked = false;
    var accessToken = context.read<UserStore>().accessToken;
    if (accessToken != '') {
      print(widget.recipeId);
      final response = await dio.get(
        '$serverURL/recipe/favorite/${widget.recipeId}',
        data: {'recipeId': widget.recipeId},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.data == 'success') {
        setState(() {
          if (tmpSaved) {
            tmpSaved = !(tmpSaved);
            liked = tmpSaved;
          } else {
            tmpSaved = true;
          }
        });
      }
      return Future.value(tmpSaved);
    } else {
      Alertlogin().needLogin(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadRecipe(widget.recipeId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Scaffold(
              body: Center(child: SpinKitPulse(
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Image.asset('assets/images/repeat/bottom_logo.png',
                          height: 40),
                    );
                  },
                )),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          } else {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: SizedBox(
                      height: 56,
                      child: Marquee(
                        text: snapshot.data['recipeName'],
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        blankSpace: 20.0,
                        velocity: 50.0,
                        pauseAfterRound: Duration(seconds: 1),
                        startPadding: 10.0,
                        accelerationDuration: Duration(seconds: 2),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: Duration(milliseconds: 1000),
                        decelerationCurve: Curves.easeOut,
                      ),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.grey[50],
                    titleSpacing: 0,
                    leading: BackButton(
                      color: Colors.black,
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: LikeButton(
                          isLiked: snapshot.data['savedRecipe'],
                          onTap: (isLiked) {
                            return toggleLike(isLiked);
                          },
                          circleColor: CircleColor(
                              start: Color(0xffff0044), end: Color(0xffff4c7c)),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Color(0xffff3333),
                            dotSecondaryColor: Color(0xffff9999),
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              tmpSaved ? Icons.favorite : Icons.favorite_border,
                              color: tmpSaved ? Colors.red : Colors.black,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Player(link: snapshot.data['recipeLink']),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 8),
                        child: Text(
                          '재료',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        )),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 20, 15),
                      child: Wrap(
                          children: List<Widget>.generate(
                        snapshot.data['recipeIngredients'].length,
                        (index) => Container(
                          padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                          margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff4C8C4C), width: 1.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${snapshot.data['recipeIngredients'][index][0]} ${snapshot.data['recipeIngredients'][index][1] != null ? snapshot.data['recipeIngredients'][index][1] : ''}',
                            style: TextStyle(
                                color: Color(0xff4C8C4C),
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      )),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xff4C8C4C), width: 1.6),
                                  shape: BoxShape.circle,
                                  // color: Color(0xffA1CBA1),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                        color: Color(0xff4C8C4C),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10), // 숫자와 텍스트 사이의 간격 조절
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data['recipeProcess'][index],
                                      softWrap: true,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: snapshot.data['recipeProcess'].length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(20, 30, 20, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '유사한 레시피',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                            Text(
                              '클릭 시 레시피 상세페이지로 이동합니다.',
                              style: TextStyle(color: Colors.black54),
                            )
                          ],
                        )),
                  ),
                  SimilarRecipe(recipeId : widget.recipeId),
                ],
              ),
            );
          }
        });
  }
}
