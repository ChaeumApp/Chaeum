import 'package:fe/repeat/search.dart';
import 'package:fe/search/searchlist.dart';
import 'package:fe/search/searchmainrecipe.dart';
import 'package:flutter/material.dart';

class SearchMain extends StatefulWidget {
  const SearchMain({super.key});

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Search(),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text('최근 검색어',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                  ),)),
              SearchList(),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Text('이런 레시피는 어때요?',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700
                    ),)),
            ],
          ),
        ),
          SearchMainRecipe(),
      ]),
    );
  }
}
