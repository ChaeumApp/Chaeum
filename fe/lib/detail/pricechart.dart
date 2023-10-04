import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shimmer/shimmer.dart';

class PriceChart extends StatefulWidget {
  PriceChart({super.key, this.ingrId});
  final ingrId;

  @override
  State<PriceChart> createState() => _PriceChartState();
}

class _PriceChartState extends State<PriceChart> {
  Dio dio = Dio();
  final serverURL = 'https://j9c204.p.ssafy.io';

  double? minY;
  double? maxY;

  Future<dynamic> getPriceChart() async {
    try {
      final response = await dio.get('$serverURL/ingr/price/${widget.ingrId}');
      var reversedData = response.data.reversed.toList();

      minY = response.data
          .map((entry) => (entry['price'] as int).toDouble())
          .fold(
              double.infinity,
              (previousValue, element) =>
                  element < previousValue! ? element : previousValue);

      maxY = response.data
          .map((entry) => (entry['price'] as int).toDouble())
          .fold(
              -double.infinity,
              (previousValue, element) =>
                  element > previousValue! ? element : previousValue);

      if (minY != null && maxY != null) {
        // minY = ((minY! / 10).ceil() * 10.0 - (minY! * 0.05)).ceilToDouble();
        // maxY = ((maxY! / 10).ceil() * 10.0 + (maxY! * 0.05)).ceilToDouble();
      }
      return reversedData;
    } catch (e) {
      print(e);
    }
  }

  String formatDate(String inputDate) {
    DateTime date = DateTime.parse(inputDate);
    String formattedDate = '${date.month}/${date.day}';
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      Color(0xffA1CBA1),
      Color(0xff4C8C4C),
    ];

    return FutureBuilder(
        future: getPriceChart(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 400,
                  height: 250,
                  color: Colors.grey,
                ));
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          } else {
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
                              left: BorderSide(color: Colors.transparent),
                              bottom: BorderSide(color: Colors.black12),
                              top: BorderSide(color: Colors.black12))),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
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
                                    text = formatDate(
                                        snapshot.data[1]['date'] as String);
                                    break;
                                  case 3:
                                    text = formatDate(
                                        snapshot.data[3]['date'] as String);
                                    break;
                                  case 5:
                                    text = formatDate(
                                        snapshot.data[5]['date'] as String);
                                    break;
                                  case 7:
                                    text = formatDate(
                                        snapshot.data[7]['date'] as String);
                                    break;
                                  case 9:
                                    text = formatDate(
                                        snapshot.data[9]['date'] as String);
                                    break;
                                  case 11:
                                    text = formatDate(
                                        snapshot.data[11]['date'] as String);
                                    break;
                                }
                                return Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    text,
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              if (value == minY) {
                                return Text('${minY?.toInt()}');
                              } else if (value == maxY) {
                                return Text('${maxY?.toInt()}');
                              } else {
                                return Text('');
                              }
                            },
                          ))),
                      maxX: 11.5,
                      maxY: maxY,
                      minY: minY,
                      minX: -0.5,
                      lineBarsData: [
                        LineChartBarData(
                            spots: [
                              FlSpot(
                                  0,
                                  (snapshot.data[0]['price'] as int)
                                      .toDouble()),
                              FlSpot(
                                  1,
                                  (snapshot.data[1]['price'] as int)
                                      .toDouble()),
                              FlSpot(
                                  2,
                                  (snapshot.data[2]['price'] as int)
                                      .toDouble()),
                              FlSpot(
                                  3,
                                  (snapshot.data[3]['price'] as int)
                                      .toDouble()),
                              FlSpot(
                                  4,
                                  (snapshot.data[4]['price'] as int)
                                      .toDouble()),
                              FlSpot(
                                  5,
                                  (snapshot.data[5]['price'] as int)
                                      .toDouble()),
                              FlSpot(
                                  6,
                                  (snapshot.data[6]['price'] as int)
                                      .toDouble()),
                              FlSpot(
                                  7,
                                  (snapshot.data[7]['price'] as int)
                                      .toDouble()),
                              FlSpot(
                                  8,
                                  (snapshot.data[8]['price'] as int)
                                      .toDouble()),
                              FlSpot(
                                  9,
                                  (snapshot.data[9]['price'] as int)
                                      .toDouble()),
                              FlSpot(
                                  10,
                                  (snapshot.data[10]['price'] as int)
                                      .toDouble()),
                              FlSpot(
                                  11,
                                  (snapshot.data[11]['price'] as int)
                                      .toDouble()),
                            ],
                            isCurved: false,
                            color: Color(0xffA1CBA1),
                            barWidth: 3,
                            belowBarData: BarAreaData(),
                            dotData: FlDotData(
                                getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                color: const Color(0xffA1CBA1),
                                strokeWidth: 0,
                                radius: 5,
                              );
                            })),
                      ],
                      lineTouchData: LineTouchData(
                        enabled: true,
                        touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: Colors.white,
                            fitInsideVertically: true,
                            tooltipBorder: BorderSide(color: Color(0xffA1CBA1)),
                            fitInsideHorizontally: true,
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map(
                                (LineBarSpot touchedSpot) {
                                  const textStyle = TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600);
                                  return LineTooltipItem(
                                    '${touchedSpot.y.toStringAsFixed(0)}원',
                                    textStyle,
                                  );
                                },
                              ).toList();
                            }),
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
        });
  }
}
