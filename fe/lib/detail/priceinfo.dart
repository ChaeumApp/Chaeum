import 'package:flutter/material.dart';
import './pricechart.dart';
import './pricetable.dart';

class PriceInfo extends StatelessWidget {
  const PriceInfo({super.key, this.ingrId});
  final ingrId;

  TextStyle titleStyle(){
    return const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 21,
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(25, 13, 25, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Text('최근 3개월 가격 변동', style: titleStyle())),
                        Text('100g(ml)당 가격', style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffA7A7A7)
                        )),
                      ],
                    )),
                PriceChart(ingrId : ingrId),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 35, 0, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                            child: Text('가격 비교', style: titleStyle())),
                        Text('클릭시 쇼핑몰로 이동합니다', style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffA7A7A7)
                        )),
                      ],
                    )),
                PriceTable(ingrId : ingrId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
