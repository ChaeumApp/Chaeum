import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PriceTable extends StatefulWidget {
  PriceTable({super.key});

  @override
  State<PriceTable> createState() => _PriceTableState();
}

class _PriceTableState extends State<PriceTable> {
  Dio dio = Dio();
  final serverURL = 'http://j9c204.p.ssafy.io';

  Future<dynamic> getPriceTable() async {
    try {
      final response = await dio.get('$serverURL/recipe');
      return response.data;
    } catch (e) {
      print(e);
    }
  }


  var data = [
    {'price': 4350, 'site': 'naver'},
    {'price': 4360, 'site': 'naver'},
    {'price': 4430, 'site': 'coupang'},
    {'price': 4500, 'site': 'coupang'},
    {'price': 4350, 'site': 'naver'},
    {'price': 4360, 'site': 'naver'},
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getPriceTable(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 400,
                  height: 200,
                  color: Colors.grey,
                )
            );
          }

          else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),

              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          }


          else {
            return
//     ListView.builder(
//         itemCount: data.length,
//         shrinkWrap: true,
//         itemBuilder: (BuildContext context, int index) {
//           return SizedBox(
//             height: 50,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                     width: MediaQuery.of(context).size.width / 3,
//                     child: Text((data[index]['price'] as int).toString())),
//                 SizedBox(
//                   child: Image.asset(
//                       '${data[index]['site'] == 'naver' ? 'assets/images/detail/naver_shopping_logo.png' : 'assets/images/detail/coupang_logo.png'}',
//                   width: 40,),
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }

              Table(
                columnWidths: const <int, TableColumnWidth>{
                  0 : FlexColumnWidth(),
                  1 : FlexColumnWidth(),
                },
                children: [
                  TableRow(children: [
                    DataTable(
                        dataRowMinHeight: 50,
                        dataRowMaxHeight: 50,
                        columns: [
                          DataColumn(label: Text('가격', style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                          ),)),
                          DataColumn(label: Text('사이트', style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                          ),))
                        ],
                        rows: data.map((entry) => DataRow(
                          cells: [
                            DataCell(Text('${entry['price'] as int}원',
                              style: TextStyle(
                                  fontSize: 16
                              ),)),
                            DataCell(Row(
                              children: [
                                // Container(
                                //     width: 65,
                                //     child: Text(entry['site'] as String)),
                                Container(
                                    width: 50,
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Image.asset('${entry['site'] == 'naver' ? 'assets/images/detail/naver_shopping_logo.png' : 'assets/images/detail/coupang_logo.png'}'))
                              ],
                            )),
                          ],
                        )).toList()),
                  ]),
                ],
              );
          }
        });

}
}
