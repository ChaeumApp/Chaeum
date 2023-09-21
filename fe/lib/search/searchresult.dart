import 'package:fe/search/searchingr.dart';
import 'package:fe/search/searchrecipe.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key, this.searchWord});
  final searchWord;


  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  TextEditingController word = TextEditingController();
  String _textFieldValue = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    word.text = _textFieldValue;
  }

  @override
  void dispose() {
    word.dispose();
    super.dispose();
  }

  void _refresh(value) {
    setState(() {
      _textFieldValue = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child:DefaultTabController(
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
                onSubmitted: (value){
                  context.read<UserStore>().addSearchList(value);
                  print(context.read<UserStore>().searchList);
                  _refresh(value);
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 13.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Color(0xffA3CCA3), width: 2.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Color(0xffA3CCA3), width: 2.5),
                  ),
                ),
              ),
              bottom: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Color(0xffD0D0D0),
                labelPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16
                ),
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
                    SearchIngr(),
                    SearchRecipe()
                  ],
                ),

            ),
        ),
    );
  }
}
