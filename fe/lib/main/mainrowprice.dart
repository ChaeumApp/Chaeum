import 'package:dio/dio.dart';
import 'package:fe/api/click.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../detail/detail.dart';

class MainRowPrice extends StatefulWidget {
  const MainRowPrice({super.key});

  @override
  State<MainRowPrice> createState() => _MainRowPriceState();
}

class _MainRowPriceState extends State<MainRowPrice> {
  Dio dio = Dio();
  final serverURL = 'https://j9c204.p.ssafy.io';

  Future<dynamic> getLowPrice() async {
    try {
      final response = await dio.get('$serverURL/recipe');
      return response.data;
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    var ranking = [
      {
        'rank': '1',
        'category': '복숭아',
        'image': 'paper_plane',
        'saleprice': 300,
        'saleper': 10
      },
      {
        'rank': '2',
        'category': '사과',
        'image': 'paper_plane',
        'saleprice': 300,
        'saleper': 10
      },
      {
        'rank': '3',
        'category': '배',
        'image': 'paper_plane',
        'saleprice': 300,
        'saleper': 10
      },
      {
        'rank': '4',
        'category': '양배추',
        'image': 'paper_plane',
        'saleprice': 300,
        'saleper': 10
      },
      {
        'rank': '5',
        'category': '양상추',
        'image': 'paper_plane',
        'saleprice': 300,
        'saleper': 10
      },
      {
        'rank': '6',
        'category': '우유',
        'image': 'paper_plane',
        'saleprice': 300,
        'saleper': 10
      },
      {
        'rank': '7',
        'category': '요거트',
        'image': 'paper_plane',
        'saleprice': 300,
        'saleper': 10
      },
      {
        'rank': '8',
        'category': '호두',
        'image': 'paper_plane',
        'saleprice': 300,
        'saleper': 10
      },
      {
        'rank': '9',
        'category': '당근',
        'image': 'paper_plane',
        'saleprice': 300,
        'saleper': 10
      },
      {
        'rank': '10',
        'category': '오이',
        'image': 'paper_plane',
        'saleprice': 300,
        'saleper': 10
      },
    ];

    Future<dynamic> clickIngr(ingrId) async {
      var accessToken = context.read<UserStore>().accessToken;
      print(accessToken);
      if(accessToken != ''){
        try {
          final response = await dio.post('$serverURL/ingr/selected', data: {'ingrId' : ingrId},
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

    return FutureBuilder(future: getLowPrice(),
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
                        SizedBox(width: 10), // 네모간의 간격 조절
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
                        SizedBox(width: 10), // 네모간의 간격 조절
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
                height: 200,
                margin: EdgeInsets.fromLTRB(0, 8, 10, 0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (c, i) {
                      return InkWell(
                        onTap: () {
                          clickIngr(ranking[i]['rank']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Detail(category: ranking[i]['rank'])));
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
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(161, 203, 161, 0.8),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 5.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(3, 3),
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${ranking[i]['rank']}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                  '${ranking[i]['category']}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff4C3273)),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text(
                                    '어제보다 ${ranking[i]['saleprice']}원(${ranking[i]['saleper']}%) 더 싸요!',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
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
