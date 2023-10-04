import 'package:dio/dio.dart';
import 'package:fe/detail/detail.dart';
import 'package:fe/ingredients/ingrmain.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchIngr extends StatefulWidget {
  const SearchIngr({super.key, this.scrollController, this.data});
  final scrollController;
  final data;

  @override
  State<SearchIngr> createState() => _SearchIngrState();
}

class _SearchIngrState extends State<SearchIngr> {


  Dio dio = Dio();
  final serverURL = 'https://j9c204.p.ssafy.io';


  Future<dynamic> clickIngr(ingrId) async {
    var accessToken = context.read<UserStore>().accessToken;
    print(accessToken);
    print(ingrId);
    if(accessToken != ''){
      try {
        final response = await dio.post('$serverURL/ingr/selected', data: {'ingrId' : ingrId},
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ),);
        return response.data;
      } catch (e) {
        print(e);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.scrollController,
      itemCount: (widget.data.length + 1) ~/ 2 + 2,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 3),
            child: Text(
              '식재료 검색 결과',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          );
        } else if (index == 1) {
          return Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: Text('총 ${widget.data.length}개 식재료'),
          );
        } else {
          final productIndex1 = (index - 2) * 2;
          final productIndex2 = productIndex1 + 1;

          if (productIndex2 >= widget.data.length) {
            return Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 2, 0, 6),
                    child: InkWell(
                      onTap: (){
                        clickIngr(widget.data[productIndex1]['ingrId']);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detail(
                                    category: widget.data[productIndex1]['ingrId'])));
                      },
                      child: Image.asset(
                        'assets/images/ingr/${widget.data[productIndex1]['ingrName']}.jpg',
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    IngrMain(catId : widget.data[productIndex1]['category']['catId'], subCatId : 0,
                                        catName: widget.data[productIndex1]['category']['catName'], sortNum : 0)));
                      },
                      child: Text(
                        '${widget.data[productIndex1]['category']['catName']}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      clickIngr(widget.data[productIndex1]['ingrId']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Detail(
                                  category: widget.data[productIndex1]['ingrId'])));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      height: 35,
                      child: Text(
                        '${widget.data[productIndex1]['ingrName'].toString().length > 7 ? widget.data[productIndex1]['ingrName'].toString().substring(0, 7) : widget.data[productIndex1]['ingrName']}'
                            '${widget.data[productIndex1]['ingrName'].toString().length > 7 ? "..." : ""}',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 2, 0, 6),
                            child: InkWell(
                              onTap: (){
                                clickIngr(widget.data[productIndex1]['ingrId']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Detail(
                                            category: widget.data[productIndex1]['ingrId'])));
                              },
                              child: Image.asset(
                                'assets/images/ingr/${widget.data[productIndex1]['ingrName']}.jpg',
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          IngrMain(catId : widget.data[productIndex1]['category']['catId'], subCatId : 0,
                                              catName: widget.data[productIndex1]['category']['catName'], sortNum : 0)));
                            },
                            child: Text(
                              '${widget.data[productIndex1]['category']['catName']}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              clickIngr(widget.data[productIndex1]['ingrId']);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detail(
                                          category: widget.data[productIndex1]['ingrId'])));
                            },
                            child: SizedBox(
                              height: 35,
                              child: Text(
                                '${widget.data[productIndex1]['ingrName'].toString().length > 7 ? widget.data[productIndex1]['ingrName'].toString().substring(0, 7) : widget.data[productIndex1]['ingrName']}' '${widget.data[productIndex1]['title'].toString().length > 7 ? "..." : ""}',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 2, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
                            child: InkWell(
                              onTap: (){
                                clickIngr(widget.data[productIndex2]['ingrId']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Detail(
                                            category: widget.data[productIndex2]['ingrId'])));
                              },
                              child: Image.asset(
                                'assets/images/ingr/${widget.data[productIndex2]['ingrName']}.jpg',
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 2),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            IngrMain(catId : widget.data[productIndex2]['category']['catId'], subCatId : 0,
                                                catName: widget.data[productIndex2]['category']['catName'], sortNum : 0)));
                              },
                              child: Text(
                                '${widget.data[productIndex2]['category']['catName']}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              clickIngr(widget.data[productIndex2]['ingrId']);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detail(
                                          category: widget.data[productIndex2]['ingrId'])));
                            },
                            child: SizedBox(
                              height: 35,
                              child: Text(
                                '${widget.data[productIndex2]['ingrName'].toString().length > 7 ? widget.data[productIndex2]['ingrName'].toString().substring(0, 7) : widget.data[productIndex2]['ingrName']}' '${widget.data[productIndex2]['ingrName'].toString().length > 7 ? "..." : ""}',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
      });
    }
}
