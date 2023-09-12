import 'package:flutter/material.dart';

class PriceTable extends StatelessWidget {
  PriceTable({super.key});

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
}
