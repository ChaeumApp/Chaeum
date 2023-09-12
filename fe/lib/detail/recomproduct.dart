import 'package:flutter/material.dart';
import './productlist.dart';

class RecommendProduct extends StatefulWidget {
  const RecommendProduct({super.key});

  @override
  State<RecommendProduct> createState() => _RecommendProductState();
}

class _RecommendProductState extends State<RecommendProduct> {
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

  _RecommendProductState() {
    selectedVal = sort[0];
  }

  var sort = ['최저가순', '랭킹순', '리뷰순'];
  String? selectedVal = "최저가순";

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('총 ${product.length}개',
                style: TextStyle(fontSize: 15),),
                SizedBox(
                  height: 30,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffA1CBA1), width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: DropdownButton(
                        underline: Container(),
                        icon: Icon(Icons.keyboard_arrow_down,
                        color: Color(0xffA1CBA1),
                        size: 25),
                        padding: EdgeInsets.fromLTRB(15, 0, 7, 0),
                        style: TextStyle(color: Colors.black,
                        fontSize: 14),
                        value: selectedVal,
                        items: sort.map((e) => DropdownMenuItem(
                          value: e,
                          child: Container(
                              width: 55,
                              child: Text(e),),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedVal = val as String;
                          });
                        },
                        selectedItemBuilder: (BuildContext context){
                          return sort.map((String value){
                            return Center(
                              child: Text(
                                selectedVal ?? "", style: TextStyle(
                                  color: Color(0xffA1CBA1),
                              fontWeight: FontWeight.w700),
                              ),
                            );
                          }).toList();
                        },
                    itemHeight: 50),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ProductList(product : product)),
          ),
        ],
      );
  }
}
