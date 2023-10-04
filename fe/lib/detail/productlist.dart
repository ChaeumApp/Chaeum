import 'package:dio/dio.dart';
import 'package:fe/store/userstore.dart';
import 'package:fe/webview/webview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, this.product, this.scrollController});

  final product;
  final scrollController;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Dio dio = Dio();
  final serverURL = 'https://j9c204.p.ssafy.io';


  Future<dynamic> clickItem(itemId) async {
    var accessToken = context.read<UserStore>().accessToken;
    if(accessToken != ''){
      try {
        final response = await dio.post('$serverURL/item/selected', data: {'itemId' : itemId},
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ),);
        return response.data;
      } catch (e) {
        print(e);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 7 / 11,
          mainAxisSpacing: 10,
          crossAxisSpacing: 25,
        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                clickItem(widget.product[index]['itemId']);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebviewPage(url : widget.product[index]['itemStoreLink'],
                            itemId : widget.product[index]['itemId'])));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 8,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                      child: Image.network(
                        '${widget.product[index]['itemImage']}',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: SizedBox(
                      height: 35,
                      child: Text(
                        '${widget.product[index]['itemName']!.length > 25 ? widget.product[index]['itemName']?.substring(0, 25) : widget.product[index]['itemName']}'
                            '${widget.product[index]['itemName']!.length > 25 ? "..." : ""}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${NumberFormat('#,###').format(widget.product[index]['itemPrice'])}원',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff73324C),
                          ),
                        ),
                        SizedBox(
                          width: 45,
                          child: Image.asset(
                            '${widget.product[index]['itemStore'] == 'Naver' ? 'assets/images/detail/naver_shopping_logo.png' : 'assets/images/detail/coupang_logo.png'}',
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          childCount: widget.product.length,
        ),
      ),
    );
  }
}
