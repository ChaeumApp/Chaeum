import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../webview/webview.dart';

class MainBest extends StatefulWidget {
  const MainBest({super.key});

  @override
  State<MainBest> createState() => _MainBestState();
}

class _MainBestState extends State<MainBest> {

  Dio dio = Dio();
  final serverURL = 'https://j9c204.p.ssafy.io';
  // 얻어오는거
  Future<dynamic> getMainBest() async {
    try {
      final response = await dio.get('$serverURL/item/best');
      var responseData = response.data;

      if (responseData.length > 10) {
        return responseData.sublist(0, 10);
      } else {
        return responseData;
      }
    } catch (e) {
      print(e);
    }
  }
  // 상품 클릭하는거
  // 상품아이디!!!!!
  Future<dynamic> clickItem(itemId) async {
    var accessToken = context.read<UserStore>().accessToken;
    print(accessToken);
    if(accessToken != ''){
      try {
        final response = await dio.post('$serverURL/item/selected', data: {'itemId' : itemId},
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
                    itemCount: snapshot.data.length,
                    itemBuilder: (c, i) {
                      return GestureDetector(
                        onTap: (){
                          clickItem(snapshot.data[i]['itemId']);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewPage(url : snapshot.data[i]['itemStoreLink'], itemId : snapshot.data[i]['itemId'])));
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
                                    child: Image.network(snapshot.data[i]['itemImage'],
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
                                          '${i+1}',
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
                                    '${snapshot.data[i]['itemName']!.length > 15 ? snapshot.data[i]['itemName']?.substring(0, 15) : snapshot.data[i]['itemName']}'
                                        '${snapshot.data[i]['itemName']!.length > 15 ? "..." : ""}',
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
