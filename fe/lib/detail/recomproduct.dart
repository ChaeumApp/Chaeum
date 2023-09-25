import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './productlist.dart';

class RecommendProduct extends StatefulWidget {
  const RecommendProduct({super.key, this.ingrId, this.scrollController});
  final ingrId;
  final scrollController;

  @override
  State<RecommendProduct> createState() => _RecommendProductState();
}

class _RecommendProductState extends State<RecommendProduct> {
  Dio dio = Dio();
  final serverURL = 'http://j9c204.p.ssafy.io';

  Future<dynamic> getProductList() async {
    try {
      final response = await dio.get('$serverURL/item/${widget.ingrId}');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

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

  _RecommendProductState() {
    selectedVal = sort[0];
  }

  var sort = ['추천순', '가나다순'];
  String? selectedVal = "추천순";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getProductList(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
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
            return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${snapshot.data.length}개 상품',
                          style: TextStyle(fontSize: 15),),
                          // SizedBox(
                          //   height: 30,
                          //   child: DecoratedBox(
                          //     decoration: BoxDecoration(
                          //       border: Border.all(color: Color(0xffA1CBA1), width: 1.5),
                          //       borderRadius: BorderRadius.circular(30),
                          //     ),
                          //     child: DropdownButton(
                          //         underline: Container(),
                          //         icon: Icon(Icons.keyboard_arrow_down,
                          //         color: Color(0xffA1CBA1),
                          //         size: 25),
                          //         padding: EdgeInsets.fromLTRB(15, 0, 7, 0),
                          //         style: TextStyle(color: Colors.black,
                          //         fontSize: 14),
                          //         value: selectedVal,
                          //         items: sort.map((e) => DropdownMenuItem(
                          //           value: e,
                          //           child: Container(
                          //               width: 55,
                          //               child: Text(e),),
                          //                 ))
                          //             .toList(),
                          //         onChanged: (val) {
                          //           setState(() {
                          //             selectedVal = val as String;
                          //           });
                          //         },
                          //         selectedItemBuilder: (BuildContext context){
                          //           return sort.map((String value){
                          //             return Center(
                          //               child: Text(
                          //                 selectedVal ?? "", style: TextStyle(
                          //                   color: Color(0xffA1CBA1),
                          //               fontWeight: FontWeight.w700),
                          //               ),
                          //             );
                          //           }).toList();
                          //         },
                          //     itemHeight: 50),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  ProductList(product : snapshot.data, scrollController : widget.scrollController)
                ],
              );
          }
        });
  }
}
