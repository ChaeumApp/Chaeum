import 'package:fe/main.dart';
import 'package:fe/search/searchresult.dart';
import 'package:fe/store/searchstore.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchController = TextEditingController();

  Future<void> addWordToList(String word) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> wordList = prefs.getStringList('wordList') ?? [];
    wordList.insert(0, word);
    await prefs.setStringList('wordList', wordList);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              flex: 2,
              child: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                        Main(initialTabIndex : 2)
                    ));
                  },
                  child: Center(child: Image.asset('assets/images/repeat/top_logo.png'))),
              ),
          Flexible(
            flex: 9,
            child: TextField(
              controller: searchController,
              onSubmitted: (value){
                addWordToList(value);
                context.read<SearchStore>().watchSearch();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchResult(searchWord: value)));
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 13.0),
              hintText: '검색어를 입력하세요.',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Color(0xffA3CCA3), width: 2.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Color(0xffA3CCA3), width: 2.5),
              ),
            ),
          ),)
        ],),
    );
  }
}
