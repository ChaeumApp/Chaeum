import 'package:dio/dio.dart';
import 'package:fe/store/userstore.dart';
import 'package:fe/webview/webview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class PriceTable extends StatefulWidget {
  PriceTable({super.key, this.ingrId});

  final ingrId;

  @override
  State<PriceTable> createState() => _PriceTableState();
}

class _PriceTableState extends State<PriceTable> {
  Dio dio = Dio();
  final serverURL = 'https://j9c204.p.ssafy.io';

  Future<List<dynamic>> getPriceTable() async {
    try {
      final response = await dio.get('$serverURL/item/${widget.ingrId}');
      final resultData = List.from(response.data);
      resultData.sort((a, b) => a['itemPrice'].compareTo(b['itemPrice'])); // 정렬
      if(resultData.length > 10) {
        return resultData.take(10).toList();
      } return resultData;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> clickItem(itemId) async {
    var accessToken = context.read<UserStore>().accessToken;
    print(accessToken);
    if(accessToken != ''){
      try {
        final response = await dio.post('$serverURL/item/selected', data: {'itemId' : itemId},
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ),);
        print(response.data);
        return response.data;
      } catch (e) {
        print(e);
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPriceTable(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 400,
              height: 200,
              color: Colors.grey,
            ),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(fontSize: 15),
            ),
          );
        } else {
          return Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
            },
            children: [
              TableRow(
                children: [
                  DataTable(
                    dataRowMinHeight: 50,
                    dataRowMaxHeight: 50,
                    columns: [
                      DataColumn(
                        label: Text(
                          '가격',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          '사이트',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                    rows: (snapshot.data as List).map<DataRow>((entry) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              '${entry['itemPrice'] as int}원',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: InkWell(
                                    onTap: (){
                                      clickItem(entry['itemId']);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => WebviewPage(url : entry['itemStoreLink'],
                                                  itemId : entry['itemId'])));
                                    },
                                    child: Image.asset(
                                      '${entry['itemStore'] != 'Coupang' ? 'assets/images/detail/naver_shopping_logo.png' : 'assets/images/detail/coupang_logo.png'}',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
