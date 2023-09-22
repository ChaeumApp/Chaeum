import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shimmer/shimmer.dart';
import '../webview/webview.dart';

class MainBest extends StatefulWidget {
  const MainBest({super.key});

  @override
  State<MainBest> createState() => _MainBestState();
}

class _MainBestState extends State<MainBest> {

  Dio dio = Dio();
  final serverURL = 'http://j9c204.p.ssafy.io:8080';
  // 얻어오는거
  Future<dynamic> getMainBest() async {
    try {
      final response = await dio.get('$serverURL/recipe');
      return response.data;
    } catch (e) {
      print(e);
    }
  }
  // 상품 클릭하는거
  // 상품아이디!!!!!
  Future<dynamic> clickItem() async {
    try {
      final response = await dio.get('$serverURL/item/selected');
      return response.data;
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    var ranking = [
      {'rank': '1', 'title': '여기는1위자리의그것입니다', 'image': 'paper_plane'},
      {'rank': '2', 'title': '여기는2위자리의제목입니다자를예정이죠', 'image': 'paper_plane'},
      {'rank': '3', 'title': '여기는3위자리입니다하하', 'image': 'paper_plane'},
      {'rank': '4', 'title': '여기는4위', 'image': 'paper_plane'},
      {'rank': '5', 'title': '여기는4위', 'image': 'paper_plane'},
      {'rank': '6', 'title': '여기는4위', 'image': 'paper_plane'},
      {'rank': '7', 'title': '여기는4위', 'image': 'paper_plane'},
      {'rank': '8', 'title': '여기는4위', 'image': 'paper_plane'},
      {'rank': '9', 'title': '여기는4위', 'image': 'paper_plane'},
      {'rank': '10', 'title': '여기는4위', 'image': 'paper_plane'},
    ];

    return FutureBuilder(future: getMainBest(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return SliverToBoxAdapter(
              child: Container(
                width: 450,
                height: 170,
                margin: EdgeInsets.fromLTRB(15, 8, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: 120,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),)
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                              width: 120,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5),)
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                              width: 120,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5),)
                          )
                        ],
                      ),
                    ),
                  ],
                )
            ));
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
            return SliverToBoxAdapter(
              child: Container(
                width: 1500,
                height: 170,
                margin: EdgeInsets.fromLTRB(0, 8, 10, 0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (c, i) {
                      return GestureDetector(
                        onTap: (){
                          // 상품클릭함수 추가해야할거있음!!!
                          clickItem();
                          // 웹뷰페이지에 전달하는 주소도!!
                          Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewPage()));
                        },
                        child: Container(
                          width: 120,
                          height: 150,
                          margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      'assets/images/temporary/${ranking[i]['image']}.jpg',
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(76, 140, 76, 0.8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.8),
                                            blurRadius: 5.0,
                                            spreadRadius: 0.0,
                                            offset: Offset(2, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5))),
                                    child: Center(
                                        child: Text(
                                          '${ranking[i]['rank']}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15),
                                        )),
                                  )
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    '${ranking[i]['title']!.length > 15 ? ranking[i]['title']?.substring(0, 15) : ranking[i]['title']}'
                                        '${ranking[i]['title']!.length > 15 ? "..." : ""}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            );
          }
        });
  }
}
