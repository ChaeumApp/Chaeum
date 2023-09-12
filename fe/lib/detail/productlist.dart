import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, this.product});

  final product;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
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
}
