import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PriceChart extends StatelessWidget {
  PriceChart({super.key});

  var data = [
    {'date': '7/12', 'price': 4600},
    {'date': '7/19', 'price': 4430},
    {'date': '7/26', 'price': 4800},
    {'date': '8/2', 'price': 4600},
    {'date': '8/9', 'price': 4230},
    {'date': '8/16', 'price': 5200},
    {'date': '8/23', 'price': 4650},
    {'date': '8/30', 'price': 4600},
    {'date': '9/6', 'price': 4700},
    {'date': '9/13', 'price': 4600},
    {'date': '9/20', 'price': 4850},
    {'date': '9/27', 'price': 4850},
  ];

  @override
  Widget build(BuildContext context) {
    double? minY = data.map((entry) => (entry['price'] as int).toDouble()).fold(
        double.infinity,
        (previousValue, element) =>
            element < previousValue! ? element : previousValue);

    double? maxY = data.map((entry) => (entry['price'] as int).toDouble()).fold(
        -double.infinity,
        (previousValue, element) =>
            element > previousValue! ? element : previousValue);

    if (minY != null && maxY != null) {
      minY = ((minY / 10).ceil() * 10.0 - (minY * 0.05)).ceilToDouble(); // 십의 자리에서 올림
      maxY = ((maxY / 10).ceil() * 10.0 + (maxY * 0.05)).ceilToDouble();
    }

    List<Color> gradientColors = [
      Color(0xffA1CBA1),
      Color(0xff4C8C4C),
    ];

    return SizedBox(
      width: 400,
      height: 250,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: LineChart(
          LineChartData(
              borderData: FlBorderData(
                show: true,
                border: Border(
                  left: BorderSide(
                    color: Colors.transparent
                  ),
                  bottom: BorderSide(
                    color: Colors.black12
                  ),
                  top: BorderSide(
                    color: Colors.black12
                  )
                )
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                // getDrawingVerticalLine: (value){
                //   return FlLine(
                //     color: Colors.black12,
                //     strokeWidth: 1
                //   );
                // },
                // drawHorizontalLine: false,
                getDrawingHorizontalLine: (value) {
                  return FlLine(color: Colors.black12, strokeWidth: 1);
                },
              ),
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: false,
                )),
                rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: false,
                )),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      String text = '';
                      switch (value.toDouble()) {
                        case 1:
                          text = data[1]['date'] as String;
                          break;
                        case 3:
                          text = data[3]['date'] as String;
                          break;
                        case 5:
                          text = data[5]['date'] as String;
                          break;
                        case 7:
                          text = data[7]['date'] as String;
                          break;
                        case 9:
                          text = data[9]['date'] as String;
                          break;
                        case 11:
                          text = data[11]['date'] as String;
                          break;
                      }
                      return Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(text, style: TextStyle(
                          color: Colors.black45
                        ),),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false
                  )
                )
              ),
              maxX: 11.5,
              maxY: maxY,
              minY: minY,
              minX: -0.5,
              lineBarsData: [
                LineChartBarData(
                    spots: [
                      FlSpot(0, (data[0]['price'] as int).toDouble()),
                      FlSpot(1, (data[1]['price'] as int).toDouble()),
                      FlSpot(2, (data[2]['price'] as int).toDouble()),
                      FlSpot(3, (data[3]['price'] as int).toDouble()),
                      FlSpot(4, (data[4]['price'] as int).toDouble()),
                      FlSpot(5, (data[5]['price'] as int).toDouble()),
                      FlSpot(6, (data[6]['price'] as int).toDouble()),
                      FlSpot(7, (data[7]['price'] as int).toDouble()),
                      FlSpot(8, (data[8]['price'] as int).toDouble()),
                      FlSpot(9, (data[9]['price'] as int).toDouble()),
                      FlSpot(10, (data[10]['price'] as int).toDouble()),
                      FlSpot(11, (data[11]['price'] as int).toDouble()),
                    ],
                    isCurved: false,
                    color: Color(0xffA1CBA1),
                    // gradient: LinearGradient(
                    //   colors: gradientColors
                    //       .map((e) => e.withOpacity(1))
                    //       .toList(),
                    // ),
                    barWidth: 3,
                    belowBarData: BarAreaData(
                        // show: true,
                        ),
                dotData: FlDotData(
                  // show: false
                  getDotPainter: (spot, percent, barData, index){
                    return FlDotCirclePainter(
                      color: const Color(0xffA1CBA1),
                      strokeWidth: 0,
                      radius: 5,
                    );
                  }
                )
                ),
              ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.white,
              tooltipBorder: BorderSide(
                color: Color(0xffA1CBA1)
              ),
              fitInsideHorizontally: true,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map(
                        (LineBarSpot touchedSpot) {
                      const textStyle = TextStyle(
                          color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600);
                      return LineTooltipItem(
                        '${touchedSpot.y.toStringAsFixed(0)}원', // 숫자를 화폐 형식으로 표시
                        textStyle,
                      );
                    },
                  ).toList();
              }
            ),
            getTouchedSpotIndicator:
                (LineChartBarData barData, List<int> indicators) {
              return indicators.map(
                    (int index) {
                  final line = FlLine(
                      color: Colors.black87,
                      strokeWidth: 1,
                      dashArray: [2, 4]);
                  return TouchedSpotIndicatorData(
                    line,
                    FlDotData(show: false),
                  );
                },
              ).toList();
            },
          )),
        ),
      ),
    );
  }
}
