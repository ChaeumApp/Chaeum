import 'package:dio/dio.dart';
import 'package:fe/detail/detail.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MainMyBest extends StatefulWidget {
  const MainMyBest({super.key});

  @override
  State<MainMyBest> createState() => _MainMyBestState();
}

class _MainMyBestState extends State<MainMyBest> {
  @override

  Dio dio = Dio();
  final serverURL = 'https://j9c204.p.ssafy.io';

  Future<dynamic> getLowPrice() async {
    var accessToken = context.read<UserStore>().accessToken;
    print(accessToken);
    try {
      final response = await dio.get('$serverURL/ingr/ateez',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<dynamic> clickIngr(ingrId) async {
      var accessToken = context
          .read<UserStore>()
          .accessToken;
      if (accessToken != '') {
        try {
          final response = await dio.post(
            '$serverURL/ingr/selected',
            data: {'ingrId': ingrId},
            options: Options(
              headers: {'Authorization': 'Bearer $accessToken'},
            ),
          );
          return response.data;
        } catch (e) {
          print(e);
        }
      }
    }

    return FutureBuilder(
        future: getLowPrice(),
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
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  width: 120,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                  ))
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
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  width: 120,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                  ))
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
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  width: 120,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    )));
          } else if (snapshot.hasError) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            );
          } else {
            return SliverToBoxAdapter(
              child: Container(
                width: 1500,
                height: 150,
                margin: EdgeInsets.fromLTRB(0, 8, 10, 0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (c, i) {
                      return InkWell(
                        onTap: () {
                          clickIngr(snapshot.data[i]['ingrId']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Detail(
                                          category: snapshot
                                              .data[i]['ingrId'])));
                        },
                        child: Container(
                          width: 120,
                          height: 130,
                          margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      'assets/images/ingr/${snapshot
                                          .data[i]['ingrName']}.jpg',
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
                                        '${i + 1}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                  '${snapshot
                                      .data[i]['ingrName']}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff4C3273)),
                                ),
                              ),
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
