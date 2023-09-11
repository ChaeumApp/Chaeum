import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PriceChart extends StatelessWidget {
  PriceChart({super.key});

  List<Map<String, double>> data = [
    {'0': 4600},
    {'2': 4800},
    {'4': 4200},
    {'6': 4650},
    {'8': 4700},
    {'10': 4850},
    {'12': 4630},
  ];


  @override
  Widget build(BuildContext context) {
    double? minY = data
        .map((entry) => entry.values.first)
        .fold(double.infinity, (previousValue, element) => element < previousValue! ? element : previousValue); // 최소값 계산

    double? maxY = data
        .map((entry) => entry.values.first)
        .fold(-double.infinity, (previousValue, element) => element > previousValue! ? element : previousValue); // 최대값 계산

    if (minY != null && maxY != null) {
      minY -= 100;
      maxY += 100;
    }

    List<Color> gradientColors = [
      Color(0xffA1CBA1),
      Color(0xff4C8C4C),
    ];
    return Expanded(
      child: Scaffold(
        body: SizedBox(
          width: 400,
          height: 350,
          child: LineChart(
              LineChartData(
                borderData: FlBorderData(
                  show: true,
                  // border: Border.all(color: Colors.transparent)
                ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    drawHorizontalLine: false,
                    // getDrawingHorizontalLine: (value) {
                    //   return FlLine(
                    //     color: Colors.transparent,
                    //     strokeWidth: 1
                    //   );
                    // }
                  ),
                  maxX: 6,
                  maxY: maxY,
                  minY: minY,
                  minX: 0,
                  lineBarsData: [
                  LineChartBarData(
                  spots: [
                  FlSpot(0, data[0]['0']!),
              FlSpot(1, data[1]['2']!),
              FlSpot(2, data[2]['4']!),
              FlSpot(3, data[3]['6']!),
              FlSpot(4, data[4]['8']!),
              FlSpot(5, data[5]['10']!),
              FlSpot(6, data[6]['12']!),
              ],
              isCurved: true,
              gradient: LinearGradient(
              colors: gradientColors.map((e)=>e.withOpacity(0.8)).toList(),),
              barWidth: 4,
                    belowBarData: BarAreaData(
                      // show: true,
                    )
          ),
          ]
      ),
    ),
        )
    ));
  }
}
