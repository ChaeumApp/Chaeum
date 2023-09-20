import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, this.product});

  final product;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Dio dio = Dio();
  final serverURL = 'http://j9c204.p.ssafy.io:8080';

  Future<dynamic> getProductList() async {
    try {
      final response = await dio.get('$serverURL/recipe');
      return response.data;
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getProductList(),
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
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 25),
              itemCount: widget.product.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                      child: Image.asset(
                        '${widget.product[index]['image']}',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: Text(
                          '${widget.product[index]['title']!.length > 25 ? widget.product[index]['title']?.substring(0, 25) : widget.product[index]['title']}'
                              '${widget.product[index]['title']!.length > 25 ? "..." : ""}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${NumberFormat('#,###').format(widget.product[index]['price'])}원',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff73324C)
                          ),),
                        SizedBox(
                          width: 45,
                          child: Image.asset('${widget.product[index]['site'] == 'naver' ? 'assets/images/detail/naver_shopping_logo.png' : 'assets/images/detail/coupang_logo.png'}',
                          ),
                        )
                        // SizedBox(
                        //   width: 45,
                        //   child: Image.asset('assets/images/detail/naver_shopping_logo.png',),
                        // )
                      ],
                    )
                  ],
                );
              },
            );
          }
        });
  }
}
