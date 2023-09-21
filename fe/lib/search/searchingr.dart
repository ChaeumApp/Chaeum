import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class SearchIngr extends StatefulWidget {
  const SearchIngr({super.key});

  @override
  State<SearchIngr> createState() => _SearchIngrState();
}

class _SearchIngrState extends State<SearchIngr> {
  var product = [
    {
      'id': 1,
      'title': '어쩌고저쩌고 상품이름',
      'image': 'assets/images/temporary/paper_plane.jpg',
      'price': 19800,
      'site': 'naver'
    },
    {
      'id': 2,
      'title': '어쩌고저쩌고 엄청나게긴상품이름입니다다다다다다다다아아아미치겠네진짜',
      'image': 'assets/images/temporary/paper_plane.jpg',
      'price': 19800,
      'site': 'coupang'
    },
    {
      'id': 3,
      'title': '어쩌고저쩌고 상품',
      'image': 'assets/images/temporary/paper_plane.jpg',
      'price': 198000,
      'site': 'naver'
    },
    {
      'id': 4,
      'title': '어쩌고저쩌고',
      'image': 'assets/images/temporary/paper_plane.jpg',
      'price': 19800,
      'site': 'coupang'
    },
    {
      'id': 5,
      'title': '어쩌고저쩌고 상품',
      'image': 'assets/images/temporary/paper_plane.jpg',
      'price': 19800,
      'site': 'coupang'
    },
    {
      'id': 6,
      'title': '어쩌고저쩌고 상품',
      'image': 'assets/images/temporary/paper_plane.jpg',
      'price': 19800,
      'site': 'naver'
    },
    {
      'id': 7,
      'title': '어쩌고저쩌고 상품',
      'image': 'assets/images/temporary/paper_plane.jpg',
      'price': 19800,
      'site': 'naver'
    },
  ];




  Dio dio = Dio();
  final serverURL = 'http://j9c204.p.ssafy.io:8080';

  Future<dynamic> searchIngr() async {
    try {
      final response = await dio.get('$serverURL/recipe');
      return response.data;
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: searchIngr(),
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
              itemCount: (product.length + 1) ~/ 2 + 2, // 변경된 itemCount
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 3),
                    child: Text(
                      '상품 검색 결과',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  );
                } else if (index == 1) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
                    child: Text('총 ${product.length}개 상품'),
                  );
                } else {
                  final productIndex1 = (index - 2) * 2;
                  final productIndex2 = productIndex1 + 1;

                  if (productIndex2 >= product.length) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 2, 0, 6),
                            child: Image.asset(
                              '${product[productIndex1]['image']}',
                              width: MediaQuery.of(context).size.width / 2 - 30,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            child: Text(
                              '소분류명',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            height: 35,
                            child: Text(
                              '${product[productIndex1]['title'].toString().length > 25 ? product[productIndex1]['title'].toString().substring(0, 25) : product[productIndex1]['title']}'
                                  '${product[productIndex1]['title'].toString().length > 25 ? "..." : ""}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${NumberFormat('#,###').format(product[productIndex1]['price'])}원',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Icon(Icons.favorite_border),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 2, 0, 6),
                                    child: Image.asset(
                                      '${product[productIndex1]['image']}',
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    '소분류명',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: Text(
                                      '${product[productIndex1]['title'].toString().length > 25 ? product[productIndex1]['title'].toString().substring(0, 25) : product[productIndex1]['title']}' '${product[productIndex1]['title'].toString().length > 25 ? "..." : ""}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${NumberFormat('#,###').format(product[productIndex1]['price'])}원',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Icon(Icons.favorite_border),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
                                    child: Image.asset(
                                      '${product[productIndex2]['image']}',
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    '소분류명',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: Text(
                                      '${product[productIndex2]['title'].toString().length > 25 ? product[productIndex2]['title'].toString().substring(0, 25) : product[productIndex2]['title']}' '${product[productIndex2]['title'].toString().length > 25 ? "..." : ""}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${NumberFormat('#,###').format(product[productIndex2]['price'])}원',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Icon(Icons.favorite_border),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
            );
          }

        });
  }
}
