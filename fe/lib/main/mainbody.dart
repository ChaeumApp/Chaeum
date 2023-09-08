import 'package:flutter/material.dart';
import '../repeat/search.dart';
import './maincategory.dart';
import './mainbest.dart';
import './mainrowprice.dart';


class Mainb extends StatefulWidget {
  const Mainb({super.key});

  @override
  State<Mainb> createState() => _MainbState();
}

class _MainbState extends State<Mainb> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: Search()),
        SliverToBoxAdapter(
            child: Image.asset('assets/images/main/main_banner1.png',)),
        Title(num : 0),
        MainCategory(),
        Title(num : 1),
        MainBest(),
        Title(num : 2),
        MainRowPrice(),
      ],
    );
  }
}




class Title extends StatelessWidget {
  Title({super.key, this.num});
  final num;

  final list = ['식재료 전체보기', '오늘의 채움 베스트', '오늘의 최저가'];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child:
    Container(
      margin: EdgeInsets.fromLTRB(15, 20, 0, 5),
      child: Text(list[num],
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    );
  }
}

