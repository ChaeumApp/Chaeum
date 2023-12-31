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
  final serverURL = 'https://j9c204.p.ssafy.io';

  Future<dynamic> getProductList() async {
    try {
      final response = await dio.get('$serverURL/item/${widget.ingrId}');
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  _RecommendProductState() {
    selectedVal = sort[0];
  }

  var sort = ['추천순', '가나다순'];
  String? selectedVal = "추천순";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getProductList(),
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
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${snapshot.data.length}개 상품',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                ProductList(
                    product: snapshot.data,
                    scrollController: widget.scrollController)
              ],
            );
          }
        });
  }
}
