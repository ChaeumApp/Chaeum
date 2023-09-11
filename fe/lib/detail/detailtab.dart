import 'package:flutter/material.dart';

class DetailTab extends StatelessWidget {
  const DetailTab({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
        labelColor: Colors.black,
        unselectedLabelColor: Color(0xffD0D0D0),
        labelPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        indicatorColor: Color(0xff4C8C4C),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Text('추천상품'),
          Text('가격정보'),
          Text('레시피'),
        ]);
  }
}
