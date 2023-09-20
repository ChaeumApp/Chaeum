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
            return Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('상품 검색 결과',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20
                  ),),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                      child: Text('총 ${product.length}개 상품')),
                  Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 4 / 7,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 25),
                        itemCount: product.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                                child: Image.asset(
                                  '${product[index]['image']}',
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text('소분류명',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54
                                    )),
                              SizedBox(
                                height: 35,
                                child: Text(
                                    '${product[index]['title'].toString().length > 25 ? product[index]['title'].toString().substring(0, 25) : product[index]['title']}'
                                        '${product[index]['title'].toString().length > 25 ? "..." : ""}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${NumberFormat('#,###').format(product[index]['price'])}원',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                    ),),
                                  Icon(Icons.favorite_border)
                                  // SizedBox(
                                  //   width: 45,
                                  //   child: Image.asset('assets/images/detail/naver_shopping_logo.png',),
                                  // )
                                ],
                              )
                            ],
                          );
                        },
                      ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
