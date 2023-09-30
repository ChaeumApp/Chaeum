import 'package:dio/dio.dart';
import 'package:fe/api/click.dart';
import 'package:fe/detail/detail.dart';
import 'package:fe/ingredients/ingrfavbtn.dart';
import 'package:fe/repeat/needlogin.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class IngrMain extends StatefulWidget {
  const IngrMain({super.key, this.catId, this.subCatId, this.catName, this.sortNum});

  final catId;
  final subCatId;
  final catName;
  final sortNum;

  @override
  State<IngrMain> createState() => _IngrMainState();
}

class _IngrMainState extends State<IngrMain> {
  final ScrollController scrollController = ScrollController();
  bool isFabVisible = false;
  int num = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  Dio dio = Dio();
  final serverURL = 'https://j9c204.p.ssafy.io';


  List<dynamic> sortData(List<dynamic> data, int sortNum) {
    if (sortNum == 1) {
      data.sort((a, b) => (a['ingrName']).compareTo(b['ingrName']));
    }
    return data;
  }

  // 받아오기
  Future<dynamic> getIngr() async {
    var accessToken = context.read<UserStore>().accessToken;
    try {
      if (accessToken != '') {
        final response = await dio.get('$serverURL/ingr/category/${widget.catId}/${widget.subCatId}',
          options: Options(
            headers: {'Authorization' : 'Bearer $accessToken'},
          ));
        final data = response.data[1];
        print(response.data[1]);
        final sortedData = sortData(data, num);
        return sortedData;
      } else {
        final response = await dio.get('$serverURL/ingr/category/${widget.catId}/${widget.subCatId}');
        final data = response.data[1];
        print(response.data[1]);
        final sortedData = sortData(data, num);
        return sortedData;
      }
    } catch (e) {
      print(e);
    }
  }

  // 관심없음
  Future<dynamic> dislikeIngr(ingrId) async {
    var accessToken = context.read<UserStore>().accessToken;
    print(accessToken);
    if (accessToken != '') {
      try {
        final response = await dio.post(
          '$serverURL/ingr/dislike',
          queryParameters: {'ingrId': ingrId},
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ),
        );
        print('관심없음 ${response.data}');
        return response.data;
      } catch (e) {
        print(e);
      }
    }
  }

  // 클릭
  Future<dynamic> clickIngr(ingrId) async {
    var accessToken = context.read<UserStore>().accessToken;
    print(accessToken);
    if (accessToken != '') {
      try {
        final response = await dio.post(
          '$serverURL/ingr/selected',
          data: {'ingrId': ingrId},
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ),
        );
        return response.data;
      } catch (e) {
        print(e);
      }
    }
  }

  _IngrMainState() {
    selectedVal = sort[0];
  }

  var sort = ['추천순', '가나다순'];
  String? selectedVal = '추천순';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getIngr(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: Text('${widget.catName}',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700)),
                backgroundColor: Colors.grey[50],
                leading: BackButton(
                  color: Colors.black,
                ),
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
            return Scaffold(
                body: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      centerTitle: true,
                      title: Text('${widget.catName}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700)),
                      backgroundColor: Colors.grey[50],
                      leading: BackButton(
                        color: Colors.black,
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 3),
                              child: Text(
                                '이런 재료들은 어때요?',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('총 ${snapshot.data.length}개',
                                      style: TextStyle(fontSize: 15)),
                                  SizedBox(
                                    height: 25,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffA1CBA1), width: 1),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: DropdownButton(
                                        underline: Container(),
                                        icon: Icon(Icons.keyboard_arrow_down,
                                            color: Color(0xffA1CBA1), size: 25),
                                        padding:
                                            EdgeInsets.fromLTRB(8, 0, 1, 0),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                        value: selectedVal,
                                        items: sort
                                            .map((e) => DropdownMenuItem(
                                                  value: e,
                                                  child: SizedBox(
                                                    width: 55,
                                                    child: Text(e),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            selectedVal = val as String;
                                            if(val == '추천순'){
                                              setState(() {
                                                num = 0;
                                              });
                                            } else {
                                              setState(() {
                                                num = 1;
                                              });
                                            }
                                          });
                                        },
                                        selectedItemBuilder:
                                            (BuildContext context) {
                                          return sort.map((String value) {
                                            return Center(
                                              child: Text(
                                                selectedVal ?? "",
                                                style: TextStyle(
                                                    color: Color(0xffA1CBA1),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            );
                                          }).toList();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    )),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 15,
                          childAspectRatio: 9 / 17,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(3),
                                    child: GestureDetector(
                                      onTap: () {
                                        clickIngr(
                                            snapshot.data[index]['ingrId']);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Detail(
                                                    category:
                                                        snapshot.data[index]
                                                            ['ingrId'])));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Image.asset(
                                          'assets/images/ingr/${snapshot.data[index]['ingrName']}.jpg',
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                    // Image.network(
                                    //   snapshot.data[index]['recipeThumbnail'],
                                    //   height: 250,
                                    //   fit: BoxFit.fill,
                                    // ),
                                    ),
                                IngrFavBtn(isFav: snapshot.data[index]['savedIngredient'], ingrId : snapshot.data[index]['ingrId']),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: GestureDetector(
                                        onTap: () {
                                          clickIngr(
                                              snapshot.data[index]['ingrId']);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Detail(
                                                      category:
                                                          snapshot.data[index]
                                                              ['ingrId'])));
                                        },
                                        child: Text(
                                          '${snapshot.data[index]['ingrName']!.length > 8 ? snapshot.data[index]['ingrName']?.substring(0, 8) : snapshot.data[index]['ingrName']}'
                                          '${snapshot.data[index]['ingrName']!.length > 8 ? "..." : ""}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                    PopupMenuButton(
                                      onSelected: (result) {
                                        final snackBar = SnackBar(
                                          content: Text("$result 설정 되었습니다."),
                                          backgroundColor: Color(0xff4C8C4C),
                                        );
                                        if(context.read<UserStore>().accessToken != ''){
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      },
                                      child: Container(
                                        height: 36,
                                        width: 18,
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.more_vert),
                                      ),
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          _menuItem("관심없음",
                                              snapshot.data[index]['ingrId'])
                                        ];
                                      },
                                    )
                                  ],
                                )
                              ],
                            );
                          },
                          childCount: snapshot.data.length,
                        ),
                      ),
                    )
                  ],
                ),
                floatingActionButton: FloatingActionButton.small(
                  onPressed: () {
                    scrollController.animateTo(
                      scrollController.position.minScrollExtent,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                  backgroundColor: Colors.grey[50],
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xffA1CBA1)),
                      borderRadius: BorderRadius.circular(12)),
                  child:
                      Icon(Icons.arrow_upward_sharp, color: Color(0xffA1CBA1)),
                ));
          }
        });
  }

  PopupMenuItem<String> _menuItem(String text, int ingrId) {
    return PopupMenuItem<String>(
      enabled: true,
      onTap: () {
        if(context.read<UserStore>().accessToken != ''){
          dislikeIngr(ingrId);
          setState(() {});
        } else {
          Alertlogin().needLogin(context);
        }
      },
      value: text,
      child: Text(
        text,
      ),
    );
  }
}
