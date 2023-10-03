import 'package:dio/dio.dart';
import 'package:fe/search/searchingr.dart';
import 'package:fe/search/searchrecipe.dart';
import 'package:fe/store/searchstore.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key, this.searchWord});

  final searchWord;

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  TextEditingController word = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    word.text = widget.searchWord;
  }

  @override
  void dispose() {
    word.dispose();
    super.dispose();
  }

  Future<void> addWordToList(String word) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> wordList = prefs.getStringList('wordList') ?? [];
    wordList.insert(0, word);
    await prefs.setStringList('wordList', wordList);
  }

  Dio dio = Dio();
  final serverURL = 'https://j9c204.p.ssafy.io';

  Future<dynamic> searchRlt() async {
    try {
      final response = await dio.get('$serverURL/search',
          queryParameters: {'query': widget.searchWord});
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: searchRlt(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 70,
                elevation: 0,
                leading: BackButton(
                  color: Colors.black,
                ),
                backgroundColor: Colors.grey[50],
                title: TextField(
                  controller: word,
                  onSubmitted: (value) {
                    addWordToList(value);
                    context.read<SearchStore>().watchSearch();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchResult(searchWord: value)));
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 13.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide:
                          BorderSide(color: Color(0xffA3CCA3), width: 2.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide:
                          BorderSide(color: Color(0xffA3CCA3), width: 2.5),
                    ),
                  ),
                ),
              ),
              body: Center(child: SpinKitPulse(
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Image.asset('assets/images/repeat/bottom_logo.png',
                        height: 40),
                  );
                },
              )),
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
            return SafeArea(
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                    appBar: AppBar(
                      toolbarHeight: 70,
                      elevation: 0,
                      leading: BackButton(
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.grey[50],
                      title: TextField(
                        controller: word,
                        onSubmitted: (value) {
                          addWordToList(value);
                          context.read<SearchStore>().watchSearch();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SearchResult(searchWord: value)));
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 13.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color(0xffA3CCA3), width: 2.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color(0xffA3CCA3), width: 2.5),
                          ),
                        ),
                      ),
                      bottom: TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Color(0xffD0D0D0),
                        labelPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                        indicatorColor: Color(0xff4C8C4C),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          Text('식재료'),
                          Text('레시피'),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        SearchIngr(
                            scrollController: scrollController,
                            data: snapshot.data['ingrList']),
                        SearchRecipe(scrollController : scrollController, data : snapshot.data['recipeList'])
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
                      child: Icon(Icons.arrow_upward_sharp,
                          color: Color(0xffA1CBA1)),
                    )),
              ),
            );
          }
        });
  }
}
