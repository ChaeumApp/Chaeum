import 'package:dio/dio.dart';
import 'package:fe/detail/detail.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class IngrMain extends StatefulWidget {
  const IngrMain({super.key, this.catId, this.subCatId, this.catName});

  final catId;
  final subCatId;
  final catName;

  @override
  State<IngrMain> createState() => _IngrMainState();
}

class _IngrMainState extends State<IngrMain> {
  Dio dio = Dio();
  final serverURL = 'http://j9c204.p.ssafy.io:8080';

  // 받아오기
  Future<dynamic> getIngr() async {
    try {
      final response = await dio.get('$serverURL/recipe');
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  // 좋아요
  // 소분류 나오면 바꿔라
  Future<dynamic> likeIngr() async {
    try {
      final response = await dio.get('ingr/favorite');
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  // 관심없음
  Future<dynamic> dislikeIngr() async {
    try {
      final response = await dio.get('ingr/dislike');
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  // 클릭
  Future<dynamic> clickIngr() async {
    try {
      final response = await dio.get('ingr/selected');
      return response.data;
    } catch (e) {
      print(e);
    }
  }




  _IngrMainState() {
    selectedVal = sort[0];
  }

  var sort = ['전체보기', '추천순'];
  String? selectedVal = "전체보기";

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
                slivers: [
                  SliverAppBar(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      padding: EdgeInsets.fromLTRB(8, 0, 1, 0),
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
                                                  fontWeight: FontWeight.w500),
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
                              GestureDetector(
                                onTap:(){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Detail(category: '여기데이터들어오면바꿔줘')));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: Image.network(
                                    snapshot.data[index]['recipeThumbnail'],
                                    height: 250,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  likeIngr();
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffD9D9D9)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                        child: Icon(Icons.shopping_cart_outlined,
                                            size: 17),
                                      ),
                                      Text(
                                        '알림설정',
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: GestureDetector(
                                      onTap:(){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Detail(category: '여기데이터들어오면바꿔줘')));
                                      },
                                      child: Text(
                                        '${snapshot.data[index]['recipeId']}',
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      height: 36,
                                      width: 48,
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.more_vert),
                                    ),
                                    itemBuilder: (BuildContext context) {
                                      return [_menuItem("관심없음")];
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
            );
          }
        });
  }

  PopupMenuItem<String> _menuItem(String text) {
    return PopupMenuItem<String>(
      enabled: true,
      onTap: () {
        dislikeIngr();
        setState(() {});
      },
      value: text,
      child: Text(
        text,
      ),
    );
  }
}
