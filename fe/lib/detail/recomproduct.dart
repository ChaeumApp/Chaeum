import 'package:flutter/material.dart';

class RecommendProduct extends StatefulWidget {
  const RecommendProduct({super.key});

  @override
  State<RecommendProduct> createState() => _RecommendProductState();
}

class _RecommendProductState extends State<RecommendProduct> {
  var product = [
    {'id':1, 'title':'어쩌고저쩌고 상품이름', 'image':'assets/images/temporary/paper_plane.jpg', 'price': 19800, 'site': 'naver'},
    {'id':2, 'title':'어쩌고저쩌고 엄청나게긴상품이름입니다', 'image':'assets/images/temporary/paper_plane.jpg', 'price': 19800, 'site': 'coupang'},
    {'id':3, 'title':'어쩌고저쩌고 상품', 'image':'assets/images/temporary/paper_plane.jpg', 'price': 19800, 'site': 'naver'},
    {'id':4, 'title':'어쩌고저쩌고', 'image':'assets/images/temporary/paper_plane.jpg', 'price': 19800, 'site': 'coupang'},
    {'id':5, 'title':'어쩌고저쩌고 상품', 'image':'assets/images/temporary/paper_plane.jpg', 'price': 19800, 'site': 'coupang'},
    {'id':6, 'title':'어쩌고저쩌고 상품', 'image':'assets/images/temporary/paper_plane.jpg', 'price': 19800, 'site': 'naver'},
  ];

  _RecommendProductState(){
    selectedVal = sort[0];
  }

  var sort = ['최저가순', '채움 랭킹순', '리뷰순'];
  String? selectedVal = "최저가순";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('총 ${product.length}개'),
            DropdownButton(
                value: selectedVal,
                items: sort.map(
                (e)=> DropdownMenuItem(child: Text(e), value: e,)
            ).toList(),
                onChanged: (val){
                  setState(() {
                    selectedVal = val as String;
                  });
                })
          ],
        )
      ],
    );
  }
}
