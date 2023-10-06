import 'package:flutter/material.dart';
import './recomproduct.dart';
import './profile.dart';
import './priceinfo.dart';
import './detailrecipe.dart';

class Detail extends StatefulWidget {
  Detail({super.key, this.category});

  final category;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final ScrollController scrollController = ScrollController();
  var data = {'saleper': 10, 'salewon': 300, 'salerank': 1};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.grey[50],
                    iconTheme: IconThemeData(color: Colors.black),
                    collapsedHeight: 325,
                    expandedHeight: 325,
                    flexibleSpace: ProfileView(category: widget.category),
                  ),
                  SliverPersistentHeader(
                    delegate: MyDelegate(TabBar(
                        labelColor: Colors.black,
                        indicatorWeight: 3,
                        unselectedLabelColor: Color(0xffD0D0D0),
                        labelPadding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                        indicatorColor: Color(0xff4C8C4C),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          Text('추천상품'),
                          Text('가격정보'),
                          Text('레시피'),
                        ])),
                    floating: true,
                    pinned: true,
                  )
                ];
              },
              body: TabBarView(children: [
                RecommendProduct(
                    ingrId: widget.category,
                    scrollController: scrollController),
                PriceInfo(ingrId: widget.category),
                DetailRecipe(ingrId: widget.category),
              ]),
            ),
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
            child: Icon(Icons.arrow_upward_sharp, color: Color(0xffA1CBA1)),
          )),
    );
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
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
