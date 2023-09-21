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
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            // physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, isScrolled) {
              return [
              SliverAppBar(
                // pinned: true,
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
              ),
                SliverPersistentHeader(
                  delegate: MyDelegate(TabBar(
                    indicatorPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                        SizedBox(
                          height: 50,
                            child: Text('식재료')),
                        SizedBox(
                          height: 40,
                            child: Text('레시피')),
                      ])),
                  floating: true,
                  pinned: true,
                )
              ];
            },
            body: TabBarView(children: [
              SearchIngr(),
              SearchRecipe()
            ]),
          ),
        ),
      ),
    );
    // return SafeArea(
    //   child: Scaffold(
    //     body: CustomScrollView(
    //       slivers: [
    //         SliverAppBar(
    //           toolbarHeight: 70,
    //           elevation: 0,
    //           leading: BackButton(
    //             color: Colors.black,
    //           ),
    //           backgroundColor: Colors.grey[50],
    //           title: TextField(
    //             controller: word,
    //             onSubmitted: (value){
    //               context.read<UserStore>().addSearchList(value);
    //               print(context.read<UserStore>().searchList);
    //               _refresh(value);
    //             },
    //             decoration: InputDecoration(
    //               contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 13.0),
    //               enabledBorder: OutlineInputBorder(
    //                 borderRadius: BorderRadius.all(Radius.circular(20)),
    //                 borderSide: BorderSide(color: Color(0xffA3CCA3), width: 2.5),
    //               ),
    //               focusedBorder: OutlineInputBorder(
    //                 borderRadius: BorderRadius.all(Radius.circular(20)),
    //                 borderSide: BorderSide(color: Color(0xffA3CCA3), width: 2.5),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Sli
    //       ],
    //     ),
    //   ),
    // );
  }
}


class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey[50],
      child: tabBar,
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
