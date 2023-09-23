import 'package:fe/store/searchstore.dart';
import 'package:flutter/material.dart';
import 'package:fe/store/userstore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SearchList extends StatefulWidget {
  SearchList({super.key});

  @override
  State<SearchList> createState() => SearchListState();
}

class SearchListState extends State<SearchList> {
  void reloadWidget() {
    setState(() {});
  }

  Future<List<String>> getSavedWordList() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('wordList') ?? [];
  }

  Future<void> removeItemFromWordList(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> wordList = prefs.getStringList('wordList') ?? [];
    if (index >= 0 && index < wordList.length) {
      wordList.removeAt(index);
      await prefs.setStringList('wordList', wordList);
    }
  }


  @override
  Widget build(BuildContext context) {
    bool dosearch = context.watch<SearchStore>().doSearch;
    return FutureBuilder(future: getSavedWordList(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.hasData == false) {
            return CircularProgressIndicator();
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
            return Container(
              margin: EdgeInsets.fromLTRB(15, 0, 20, 0),
              height: 30,
              child: snapshot.data.length > 0 ? ListView.builder(
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black45
                          ),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${snapshot.data[index]}'),
                          GestureDetector(
                            onTap: (){
                              removeItemFromWordList(index);
                              setState(() {});
                            },
                            child: Container(
                                margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Icon(Icons.close,
                                  color: Colors.black45,)),
                          ),
                        ],
                      ),
                    );
                  }) : Center(child: Text('최근 검색어가 없습니다.')),
            );
          }
        });
  }
}
