import 'package:fe/main/mainmybest.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repeat/search.dart';
import './maincategory.dart';
import './mainbest.dart';
import './mainrowprice.dart';
import './maincarousel.dart';


class Mainb extends StatefulWidget {
  const Mainb({super.key});

  @override
  State<Mainb> createState() => _MainbState();
}

class _MainbState extends State<Mainb> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final accessToken = context.read<UserStore>().accessToken;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: Search()),
        SliverToBoxAdapter(
            child: MainCarousel()),
        Title(num : 0),
        MainCategory(),
        Title(num : 1),
        MainBest(),
        if(accessToken != '') Title(num : 2),
        if(accessToken != '') MainMyBest(),
        Title(num : 3),
        MainRowPrice(),
      ],
    );
  }
}




class Title extends StatelessWidget {
  Title({super.key, this.num});
  final num;

  final list = ['식재료 전체보기', '오늘의 채움 베스트', '나를 위한 추천', '오늘의 최저가'];

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

